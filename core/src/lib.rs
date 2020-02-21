use libc::{c_char, c_double, c_int, size_t};
use std::{
    boxed::Box,
    ffi::{CStr, CString},
    slice,
};

#[no_mangle]
pub extern "C" fn hello() {
    println!("Hello, World!");
}

#[no_mangle]
pub extern "C" fn str() -> CString {
    CString::new("String from Rust!").expect("CString::new failed")
}

#[no_mangle]
pub extern "C" fn free_str(ptr: *mut c_char) {
    unsafe {
        CString::from_raw(ptr);
    }
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
pub extern "C" fn free_coordinate(x: *mut Coordinate) {
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

#[repr(C)]
pub struct Nums {
    pub len: usize,
    pub data: *mut c_int,
}

#[no_mangle]
pub extern "C" fn nums() -> *mut Nums {
    let mut data = vec![1, 2, 3].into_boxed_slice();
    let data_ptr = data.as_mut_ptr();
    let len = data.len();
    let nums = Nums {
        len,
        data: data_ptr,
    };
    std::mem::forget(data);

    Box::into_raw(Box::new(nums))
}

#[no_mangle]
pub extern "C" fn free_nums(ptr: *mut Nums) {
    unsafe {
        let nums = Box::from_raw(ptr);
        std::mem::drop(Box::from_raw(nums.data));
    }
}

#[no_mangle]
pub extern "C" fn sum(nums_ptr: *const c_int, len: size_t) -> c_int {
    let nums = unsafe { slice::from_raw_parts(nums_ptr, len as usize) };
    (*nums).iter().fold(0, |p, n| p + n)
}
