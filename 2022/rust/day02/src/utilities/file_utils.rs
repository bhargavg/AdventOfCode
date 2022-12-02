use std::env;
use std::fs;

pub fn read_file(name: &str) -> String {
    let file_path = env::current_dir().unwrap().join("inputs").join(name);
    fs::read_to_string(&file_path).unwrap_or(format!("Unable to read file at: {:?}", &file_path))
}
