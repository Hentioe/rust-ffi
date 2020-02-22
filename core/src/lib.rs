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
pub struct CArray<T> {
    pub len: usize,
    pub data: *mut T,
}

#[no_mangle]
pub extern "C" fn nums() -> *mut CArray<c_int> {
    let mut data = vec![1, 2, 3].into_boxed_slice();
    let data_ptr = data.as_mut_ptr();
    let len = data.len();
    let nums = CArray {
        len,
        data: data_ptr,
    };
    std::mem::forget(data);

    Box::into_raw(Box::new(nums))
}

#[no_mangle]
pub extern "C" fn free_int_array(ptr: *mut CArray<c_int>) {
    unsafe {
        let array = Box::from_raw(ptr);
        std::mem::drop(Box::from_raw(array.data));
    }
}

#[no_mangle]
pub extern "C" fn sum(nums_ptr: *const c_int, len: size_t) -> c_int {
    let nums = unsafe { slice::from_raw_parts(nums_ptr, len as usize) };
    (*nums).iter().fold(0, |p, n| p + n)
}

#[no_mangle]
pub extern "C" fn names() -> *mut CArray<*mut c_char> {
    let data_strs = vec![
        CString::new("小明").unwrap(),
        CString::new("小红").unwrap(),
        CString::new("小刚").unwrap(),
        CString::new("小马").unwrap(),
    ];
    let mut data_ptrs = data_strs
        .into_iter()
        .map(|s| s.into_raw())
        .collect::<Vec<*mut c_char>>()
        .into_boxed_slice();
    let len = data_ptrs.len();
    let data = data_ptrs.as_mut_ptr();
    let names = CArray { len, data };
    std::mem::forget(data_ptrs);

    Box::into_raw(Box::new(names))
}

#[no_mangle]
pub extern "C" fn free_string_array(ptr: *mut CArray<*mut c_char>) {
    unsafe {
        let array = Box::from_raw(ptr);
        slice::from_raw_parts_mut(array.data, array.len)
            .iter_mut()
            .map(|s| CString::from_raw(*s))
            .for_each(drop);
        std::mem::drop(Box::from_raw(array.data));
    }
}
