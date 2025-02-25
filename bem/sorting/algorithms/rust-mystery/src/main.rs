use clap::Parser;
use num_cpus;
use std::{
    fs::{self, File},
    io::{self, Write},
    thread,
    time::Duration,
};

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Args {
    // ID of mystery program to execute (1-4)
    #[arg(short, long)]
    mystery: Option<u8>,

    // Enable verbose output (aka solutions)
    #[arg(short, long)]
    verbose: bool,
}

fn main() {
    let args = Args::parse();

    let mystery = match args.mystery {
        Some(m) => m,
        None => {
            println!("Which mystery program would you like to execute (1-4)? ");
            let mut input = String::new();
            io::stdin().read_line(&mut input).unwrap();
            input.trim().parse().unwrap_or(0)
        }
    };

    match mystery {
        1 => mystery_wait(args.verbose),
        2 => mystery_fibonacci(args.verbose),
        3 => mystery_disk_io(args.verbose),
        4 => mystery_parallel_cpu(args.verbose),
        _ => eprintln!("Please select a mystery program between 1 and 4."),
    }
}

fn mystery_wait(verbose: bool) {
    println!("Execution Mystery Program 1");
    if verbose {
        println!("  Waiting for 2 seconds...");
        println!("    thread::sleep(Duration::from_secs(2));");
    }
    thread::sleep(Duration::from_secs(2));
    if verbose {
        println!("  Done waiting!");
    }
}

fn mystery_fibonacci(verbose: bool) {
    println!("Execution Mystery Program 2");
    let n = 45; // sufficiently large to be CPU-intensive
    if verbose {
        println!("  Calculating Fibonacci Sequence for 50 iterations");
        println!("    if n <= 1 {{\n      n\n    }} else {{\n      fibonacci(n - 1) + fibonacci(n - 2)\n    }}");
    }
    let result = fibonacci(n);
    if verbose {
        println!("  Fibonacci({}) = {}", n, result);
    }
}

fn fibonacci(n: u64) -> u64 {
    if n <= 1 {
        n
    } else {
        fibonacci(n - 1) + fibonacci(n - 2)
    }
}

fn mystery_disk_io(verbose: bool) {
    println!("Execution Mystery Program 3");
    if verbose {
        println!("  Performing heavy disk IO. Creating 1000 files with u32 values");
        println!("    for i in 0..1000 {{\n      let file_path = format!(\"{{}}/file_{{}}.txt\", dir, i);\n      let mut file = File::create(&file_path).unwrap();\n      writeln!(file, \"This is some temporary content for file number {{}}.\", i)).unwrap()\n    }}");
    }
    let dir = "temp_mystery_io";
    fs::create_dir_all(dir).unwrap();

    for i in 0..1000 {
        let file_path = format!("{}/file_{}.txt", dir, i);
        let mut file = File::create(&file_path).unwrap();
        writeln!(
            file,
            "This is some temporary content for file number {}.",
            i
        )
        .unwrap();
    }

    if verbose {
        println!("  Files created. Cleaning up...");
    }
    fs::remove_dir_all(dir).unwrap();
    if verbose {
        println!("  Cleanup complete!");
    }
}

fn mystery_parallel_cpu(verbose: bool) {
    println!("Execution Mystery Program 4");
    if verbose {
        println!("  Using all CPU cores...");
        println!("    for _ in 0..cores {{\n      handles.push(thread::spawn(|| {{\n        let mut x: f64 = 0.0;\n        for i in 0..1_000_000_000 {{\n          x = x + i as f64;\n        }}\n        x\n      }}));\n    }}");
    }

    let cores = num_cpus::get();
    let mut handles = Vec::new();

    for _ in 0..cores {
        handles.push(thread::spawn(|| {
            let mut x: f64 = 0.0;
            for i in 0..1_000_000_000 {
                x = x + i as f64;
            }
            x
        }));
    }

    for handle in handles {
        handle.join().unwrap();
    }

    if verbose {
        println!("  Completed parallel CPU task!");
    }
}
