//! flash.filters.DisplacementMapFilter object

use crate::avm1::clamp::Clamp;
use crate::avm1::function::FunctionObject;
use crate::avm1::object::NativeObject;
use crate::avm1::property_decl::{define_properties_on, Declaration};
use crate::avm1::{Activation, Error, Object, Value};
use crate::bitmap::bitmap_data::BitmapDataWrapper;
use crate::context::UpdateContext;
use crate::string::StringContext;
use gc_arena::barrier::unlock;
use gc_arena::lock::Lock;
use gc_arena::{Collect, Gc, Mutation};
use ruffle_macros::istr;
use ruffle_render::filters::DisplacementMapFilterMode;
use std::cell::Cell;
use std::fmt::Debug;
use swf::{Color, Point};

#[derive(Clone, Collect, Debug, Default)]
#[collect(no_drop)]
struct DisplacementMapFilterData<'gc> {
    map_bitmap: Lock<Option<BitmapDataWrapper<'gc>>>,
    map_point: Cell<Point<i32>>,
    component_x: Cell<i32>,
    component_y: Cell<i32>,
    scale_x: Cell<f32>,
    scale_y: Cell<f32>,
    mode: Cell<DisplacementMapFilterMode>,
    color: Cell<Color>,
}

impl<'gc> From<ruffle_render::filters::DisplacementMapFilter> for DisplacementMapFilterData<'gc> {
    fn from(
        filter: ruffle_render::filters::DisplacementMapFilter,
    ) -> DisplacementMapFilterData<'gc> {
        Self {
            map_bitmap: Lock::new(None), // TODO: We can't store this object yet
            map_point: Cell::new(Point::new(filter.map_point.0, filter.map_point.1)),
            component_x: Cell::new(filter.component_x as i32),
            component_y: Cell::new(filter.component_y as i32),
            scale_x: Cell::new(filter.scale_x),
            scale_y: Cell::new(filter.scale_y),
            mode: Cell::new(filter.mode),
            color: Cell::new(filter.color),
        }
    }
}

#[derive(Copy, Clone, Debug, Collect)]
#[collect(no_drop)]
#[repr(transparent)]
pub struct DisplacementMapFilter<'gc>(Gc<'gc, DisplacementMapFilterData<'gc>>);

impl<'gc> DisplacementMapFilter<'gc> {
    fn new(activation: &mut Activation<'_, 'gc>, args: &[Value<'gc>]) -> Result<Self, Error<'gc>> {
        let displacement_map_filter = Self(Gc::new(activation.gc(), Default::default()));
        displacement_map_filter.set_map_bitmap(activation, args.get(0))?;
        displacement_map_filter.set_map_point(activation, args.get(1))?;
        displacement_map_filter.set_component_x(activation, args.get(2))?;
        displacement_map_filter.set_component_y(activation, args.get(3))?;
        displacement_map_filter.set_scale_x(activation, args.get(4))?;
        displacement_map_filter.set_scale_y(activation, args.get(5))?;
        displacement_map_filter.set_mode(activation, args.get(6))?;
        displacement_map_filter.set_color(activation, args.get(7))?;
        displacement_map_filter.set_alpha(activation, args.get(8))?;
        Ok(displacement_map_filter)
    }

    pub fn from_filter(
        gc_context: &Mutation<'gc>,
        filter: ruffle_render::filters::DisplacementMapFilter,
    ) -> Self {
        Self(Gc::new(gc_context, filter.into()))
    }

    pub(crate) fn duplicate(self, gc_context: &Mutation<'gc>) -> Self {
        Self(Gc::new(gc_context, self.0.as_ref().clone()))
    }

    fn map_bitmap(self, context: &mut UpdateContext<'gc>) -> Option<Object<'gc>> {
        if let Some(map_bitmap) = self.0.map_bitmap.get() {
            let proto = context.avm1.prototypes().bitmap_data;
            let result = Object::new(&context.strings, Some(proto));
            result.set_native(context.gc(), NativeObject::BitmapData(map_bitmap));
            Some(result)
        } else {
            None
        }
    }

    fn set_map_bitmap(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(Value::Object(object)) = value {
            if let NativeObject::BitmapData(bitmap_data) = object.native() {
                unlock!(
                    Gc::write(activation.gc(), self.0),
                    DisplacementMapFilterData,
                    map_bitmap
                )
                .set(Some(bitmap_data));
            }
        }
        Ok(())
    }

    fn map_point(self, activation: &mut Activation<'_, 'gc>) -> Result<Value<'gc>, Error<'gc>> {
        let map_point = self.0.map_point.get();
        let args = &[map_point.x.into(), map_point.y.into()];
        let constructor = activation.context.avm1.prototypes().point_constructor;
        constructor.construct(activation, args)
    }

    fn set_map_point(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        let Some(value) = value else { return Ok(()) };

        if let Value::Object(object) = value {
            if let Some(x) = object.get_local_stored(istr!("x"), activation, false) {
                let x = x.coerce_to_f64(activation)?.clamp_to_i32();
                if let Some(y) = object.get_local_stored(istr!("y"), activation, false) {
                    let y = y.coerce_to_f64(activation)?.clamp_to_i32();
                    self.0.map_point.set(Point::new(x, y));
                    return Ok(());
                }
            }
        }

        self.0.map_point.set(Point::default());
        Ok(())
    }

    fn component_x(self) -> i32 {
        self.0.component_x.get()
    }

    fn set_component_x(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            let component_x = value.coerce_to_i32(activation)?;
            self.0.component_x.set(component_x);
        }
        Ok(())
    }

    fn component_y(self) -> i32 {
        self.0.component_y.get()
    }

    fn set_component_y(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            let component_y = value.coerce_to_i32(activation)?;
            self.0.component_y.set(component_y);
        }
        Ok(())
    }

    fn scale_x(self) -> f32 {
        self.0.scale_x.get()
    }

    fn set_scale_x(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            const MAX: f64 = u16::MAX as f64;
            const MIN: f64 = -MAX;
            let scale_x = value.coerce_to_f64(activation)?.clamp_also_nan(MIN, MAX);
            self.0.scale_x.set(scale_x as f32);
        }
        Ok(())
    }

    fn scale_y(self) -> f32 {
        self.0.scale_y.get()
    }

    fn set_scale_y(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            const MAX: f64 = u16::MAX as f64;
            const MIN: f64 = -MAX;
            let scale_y = value.coerce_to_f64(activation)?.clamp_also_nan(MIN, MAX);
            self.0.scale_y.set(scale_y as f32);
        }
        Ok(())
    }

    fn mode(self) -> DisplacementMapFilterMode {
        self.0.mode.get()
    }

    fn set_mode(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            let mode = value.coerce_to_string(activation)?;

            let mode = if &mode == b"clamp" {
                DisplacementMapFilterMode::Clamp
            } else if &mode == b"ignore" {
                DisplacementMapFilterMode::Ignore
            } else if &mode == b"color" {
                DisplacementMapFilterMode::Color
            } else {
                DisplacementMapFilterMode::Wrap
            };

            self.0.mode.set(mode);
        }
        Ok(())
    }

    fn color(self) -> Color {
        self.0.color.get()
    }

    fn set_color(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            let value = value.coerce_to_u32(activation)?;
            let color = self.0.color.get();
            self.0.color.set(Color::from_rgb(value, color.a));
        }
        Ok(())
    }

    fn set_alpha(
        self,
        activation: &mut Activation<'_, 'gc>,
        value: Option<&Value<'gc>>,
    ) -> Result<(), Error<'gc>> {
        if let Some(value) = value {
            let alpha = value.coerce_to_f64(activation)?.clamp_also_nan(0.0, 1.0);
            let mut color = self.0.color.get();
            color.a = (alpha * 255.0) as u8;
            self.0.color.set(color);
        }
        Ok(())
    }

    pub fn filter(
        self,
        context: &mut UpdateContext<'gc>,
    ) -> ruffle_render::filters::DisplacementMapFilter {
        let filter = self.0;
        let map_point = filter.map_point.get();
        ruffle_render::filters::DisplacementMapFilter {
            color: filter.color.get(),
            component_x: filter.component_x.get() as u8,
            component_y: filter.component_y.get() as u8,
            map_bitmap: filter
                .map_bitmap
                .get()
                .map(|b| b.bitmap_handle(context.gc(), context.renderer)),
            map_point: (map_point.x, map_point.y),
            mode: filter.mode.get(),
            scale_x: filter.scale_x.get(),
            scale_y: filter.scale_y.get(),
            viewscale_x: 1.0,
            viewscale_y: 1.0,
        }
    }
}

macro_rules! displacement_map_filter_method {
    ($index:literal) => {
        |activation, this, args| method(activation, this, args, $index)
    };
}

const PROTO_DECLS: &[Declaration] = declare_properties! {
    "mapBitmap" => property(displacement_map_filter_method!(1), displacement_map_filter_method!(2));
    "mapPoint" => property(displacement_map_filter_method!(3), displacement_map_filter_method!(4));
    "componentX" => property(displacement_map_filter_method!(5), displacement_map_filter_method!(6));
    "componentY" => property(displacement_map_filter_method!(7), displacement_map_filter_method!(8));
    "scaleX" => property(displacement_map_filter_method!(9), displacement_map_filter_method!(10));
    "scaleY" => property(displacement_map_filter_method!(11), displacement_map_filter_method!(12));
    "mode" => property(displacement_map_filter_method!(13), displacement_map_filter_method!(14));
    "color" => property(displacement_map_filter_method!(15), displacement_map_filter_method!(16));
    "alpha" => property(displacement_map_filter_method!(17), displacement_map_filter_method!(18));
};

fn method<'gc>(
    activation: &mut Activation<'_, 'gc>,
    this: Object<'gc>,
    args: &[Value<'gc>],
    index: u8,
) -> Result<Value<'gc>, Error<'gc>> {
    const CONSTRUCTOR: u8 = 0;
    const GET_MAP_BITMAP: u8 = 1;
    const SET_MAP_BITMAP: u8 = 2;
    const GET_MAP_POINT: u8 = 3;
    const SET_MAP_POINT: u8 = 4;
    const GET_COMPONENT_X: u8 = 5;
    const SET_COMPONENT_X: u8 = 6;
    const GET_COMPONENT_Y: u8 = 7;
    const SET_COMPONENT_Y: u8 = 8;
    const GET_SCALE_X: u8 = 9;
    const SET_SCALE_X: u8 = 10;
    const GET_SCALE_Y: u8 = 11;
    const SET_SCALE_Y: u8 = 12;
    const GET_MODE: u8 = 13;
    const SET_MODE: u8 = 14;
    const GET_COLOR: u8 = 15;
    const SET_COLOR: u8 = 16;
    const GET_ALPHA: u8 = 17;
    const SET_ALPHA: u8 = 18;

    if index == CONSTRUCTOR {
        let displacement_map_filter = DisplacementMapFilter::new(activation, args)?;
        this.set_native(
            activation.gc(),
            NativeObject::DisplacementMapFilter(displacement_map_filter),
        );
        return Ok(this.into());
    }

    let this = match this.native() {
        NativeObject::DisplacementMapFilter(displacement_map_filter) => displacement_map_filter,
        _ => return Ok(Value::Undefined),
    };

    Ok(match index {
        GET_MAP_BITMAP => this
            .map_bitmap(activation.context)
            .map_or(Value::Undefined, Value::from),
        SET_MAP_BITMAP => {
            this.set_map_bitmap(activation, args.get(0))?;
            Value::Undefined
        }
        GET_MAP_POINT => this.map_point(activation)?,
        SET_MAP_POINT => {
            this.set_map_point(activation, args.get(0))?;
            Value::Undefined
        }
        GET_COMPONENT_X => this.component_x().into(),
        SET_COMPONENT_X => {
            this.set_component_x(activation, args.get(0))?;
            Value::Undefined
        }
        GET_COMPONENT_Y => this.component_y().into(),
        SET_COMPONENT_Y => {
            this.set_component_y(activation, args.get(0))?;
            Value::Undefined
        }
        GET_SCALE_X => this.scale_x().into(),
        SET_SCALE_X => {
            this.set_scale_x(activation, args.get(0))?;
            Value::Undefined
        }
        GET_SCALE_Y => this.scale_y().into(),
        SET_SCALE_Y => {
            this.set_scale_y(activation, args.get(0))?;
            Value::Undefined
        }
        GET_MODE => {
            let mode = match this.mode() {
                DisplacementMapFilterMode::Wrap => istr!("wrap"),
                DisplacementMapFilterMode::Clamp => istr!("clamp"),
                DisplacementMapFilterMode::Ignore => istr!("ignore"),
                DisplacementMapFilterMode::Color => istr!("color"),
            };

            mode.into()
        }
        SET_MODE => {
            this.set_mode(activation, args.get(0))?;
            Value::Undefined
        }
        GET_COLOR => this.color().to_rgb().into(),
        SET_COLOR => {
            this.set_color(activation, args.get(0))?;
            Value::Undefined
        }
        GET_ALPHA => (this.color().a as f64 / 255.0).into(),
        SET_ALPHA => {
            this.set_alpha(activation, args.get(0))?;
            Value::Undefined
        }
        _ => Value::Undefined,
    })
}

pub fn create_proto<'gc>(
    context: &mut StringContext<'gc>,
    proto: Object<'gc>,
    fn_proto: Object<'gc>,
) -> Object<'gc> {
    let displacement_map_filter_proto = Object::new(context, Some(proto));
    define_properties_on(
        PROTO_DECLS,
        context,
        displacement_map_filter_proto,
        fn_proto,
    );
    displacement_map_filter_proto
}

pub fn create_constructor<'gc>(
    context: &mut StringContext<'gc>,
    proto: Object<'gc>,
    fn_proto: Object<'gc>,
) -> Object<'gc> {
    FunctionObject::constructor(
        context,
        displacement_map_filter_method!(0),
        None,
        fn_proto,
        proto,
    )
}
