use crate::avm2::object::script_object::ScriptObjectData;
use crate::avm2::object::{ClassObject, FunctionObject, Object, TObject};
use crate::avm2::{Activation, Error};
use crate::context::UpdateContext;
use crate::net_connection::ResponderCallback;
use crate::utils::HasPrefixField;
use flash_lso::types::Value as AMFValue;
use gc_arena::barrier::unlock;
use gc_arena::{lock::Lock, Collect, Gc, GcWeak, Mutation};
use std::fmt;

/// A class instance allocator that allocates Responder objects.
pub fn responder_allocator<'gc>(
    class: ClassObject<'gc>,
    activation: &mut Activation<'_, 'gc>,
) -> Result<Object<'gc>, Error<'gc>> {
    let base = ScriptObjectData::new(class);

    Ok(ResponderObject(Gc::new(
        activation.gc(),
        ResponderObjectData {
            base,
            result: Lock::new(None),
            status: Lock::new(None),
        },
    ))
    .into())
}

#[derive(Clone, Collect, Copy)]
#[collect(no_drop)]
pub struct ResponderObject<'gc>(pub Gc<'gc, ResponderObjectData<'gc>>);

#[derive(Clone, Collect, Copy, Debug)]
#[collect(no_drop)]
pub struct ResponderObjectWeak<'gc>(pub GcWeak<'gc, ResponderObjectData<'gc>>);

impl<'gc> TObject<'gc> for ResponderObject<'gc> {
    fn gc_base(&self) -> Gc<'gc, ScriptObjectData<'gc>> {
        HasPrefixField::as_prefix_gc(self.0)
    }
}

impl<'gc> ResponderObject<'gc> {
    pub fn result(&self) -> Option<FunctionObject<'gc>> {
        self.0.result.get()
    }

    pub fn status(&self) -> Option<FunctionObject<'gc>> {
        self.0.status.get()
    }

    pub fn set_callbacks(
        &self,
        mc: &Mutation<'gc>,
        result: Option<FunctionObject<'gc>>,
        status: Option<FunctionObject<'gc>>,
    ) {
        let write = Gc::write(mc, self.0);
        unlock!(write, ResponderObjectData, result).set(result);
        unlock!(write, ResponderObjectData, status).set(status);
    }

    pub fn send_callback(
        &self,
        context: &mut UpdateContext<'gc>,
        callback: ResponderCallback,
        message: &AMFValue,
    ) -> Result<(), Error<'gc>> {
        let function = match callback {
            ResponderCallback::Result => self.0.result.get(),
            ResponderCallback::Status => self.0.status.get(),
        };

        if let Some(function) = function {
            let mut activation = Activation::from_nothing(context);
            let value = crate::avm2::amf::deserialize_value(&mut activation, message)?;
            function.call(&mut activation, (*self).into(), &[value])?;
        }

        Ok(())
    }
}

#[derive(Collect, HasPrefixField)]
#[collect(no_drop)]
#[repr(C, align(8))]
pub struct ResponderObjectData<'gc> {
    /// Base script object
    base: ScriptObjectData<'gc>,

    /// Method to call with any result
    result: Lock<Option<FunctionObject<'gc>>>,

    /// Method to call with status info (likely errors)
    status: Lock<Option<FunctionObject<'gc>>>,
}

impl fmt::Debug for ResponderObject<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "ResponderObject")
    }
}
