// Axam - 24.05.2023

mod fct;

use std::io::{BufReader, BufRead};
use std::fs::File;
use std::time::Instant;

fn main()
{
  // Select data file
  println!("Select data file on the newly opened GUI");
  let path =  native_dialog::FileDialog::new()
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
  let mut vec3: Vec<u16>;

  {
    let input = File::open(path.into_os_string().into_string().unwrap());
    let buffered = BufReader::new(input.unwrap());
    vec = Vec::<u16>::new();
    for line in buffered.lines() {
      vec.push(line.unwrap().trim().parse().unwrap())
    }
  }
  vec2 = vec.clone();
  vec3 = vec.clone();

  // Bubble sort (non-opti)
  println!("Sorting with Bubble sort (non-opti)");
  let mut start = Instant::now();
  _ = fct::bubble_sort(&mut vec, false);
  let mut elapsed = start.elapsed();
  println!(" * Bubble sort (non-opti) done in {:?} [ms]", elapsed.as_millis());

  // Bubble sort (opti)
  println!("Sorting with Bubble sort (optimized)");
  start = Instant::now();
  _ = fct::bubble_sort(&mut vec2, true);
  elapsed = start.elapsed();
  println!(" * Bubble sort (optimized) done in {:?} [ms]", elapsed.as_millis());

  // Merge Sort
  println!("Sorting with Merge sort");
  start = Instant::now();
  _ = fct::merge_sort(&mut vec3);
  elapsed = start.elapsed();
  println!(" * Merge sort done in {:?} [ms]", elapsed.as_millis());

  // Done
  let stdin = std::io::stdin();
  let mut temp = String::new();
  println!("\n\nPress any button to finish");
  stdin.read_line(&mut temp).expect(" ** Couldn’t read from stdin - exiting");
}