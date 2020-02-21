use libc::{c_char, c_double};
use std::boxed::Box;
use std::ffi::{CStr, CString};

#[no_mangle]
pub extern "C" fn hello() {
    println!("Hello, World!");
}

#[no_mangle]
pub extern "C" fn str() -> CString {
    CString::new("String from Rust!").expect("CString::new failed")
}

#[no_mangle]
pub extern "C" fn echo(s: *const c_char) {
    let cstr = unsafe { CStr::from_ptr(s) };
    println!("{}", cstr.to_str().expect("CStr.to_str failed"));
}

#[repr(C)]
#[derive(Debug)]
pub struct Coordinate {
    pub latitude: c_double,
    pub longitude: c_double,
}

#[no_mangle]
pub extern "C" fn drop_coordinate(x: *mut Coordinate) {
    unsafe {
        Box::from_raw(x);
    }
}

#[no_mangle]
pub extern "C" fn create_coordinate(latitude: c_double, longitude: c_double) -> *mut Coordinate {
    let c = Coordinate {
        latitude,
        longitude,
    };
    Box::into_raw(Box::new(c))
}
