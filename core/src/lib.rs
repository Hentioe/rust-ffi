use libc::c_char;
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
