// zas - 20.02.2025

use std::fs::File;
use std::io::{BufRead, BufReader};
use std::time::Instant;

fn main() {
    // Select data file
    println!("Select data file on the newly opened GUI");
    let path = native_dialog::FileDialog::new()
        .add_filter("Text File", &["txt"])
        .show_open_single_file()
        .unwrap();
    let path = match path {
        Some(path) => path,
        None => return,
    };
    // Read file
    println!("Reading data into memory");
    let mut vec: Vec<u16>;
    let mut vec2: Vec<u16>;

    {
        let input = File::open(path.into_os_string().into_string().unwrap());
        let buffered = BufReader::new(input.unwrap());
        vec = Vec::<u16>::new();
        for line in buffered.lines() {
            vec.push(line.unwrap().trim().parse().unwrap())
        }
    }
    vec2 = vec.clone();

    let start;
    let elapsed;

    // Glidesort
    println!("Sorting with Glidesort");
    start = Instant::now();
    _ = glidesort::sort(&mut vec2);
    elapsed = start.elapsed();
    println!(" * Glidesort done in {:?} [ms]", elapsed.as_millis());

    // Done
    let stdin = std::io::stdin();
    let mut temp = String::new();
    println!("\n\nPress any button to finish");
    stdin
        .read_line(&mut temp)
        .expect(" ** Couldn’t read from stdin - exiting");
}
