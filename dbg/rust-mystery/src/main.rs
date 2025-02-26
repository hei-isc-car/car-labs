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
            println!("Which mystery program would you like to execute (1-5)? ");
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
        5 => mystery_gpu(args.verbose).unwrap(),
        _ => eprintln!("{} is not supported. Please select a mystery program between 1 and 5.", mystery),
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


use opencl3::command_queue::{CommandQueue, CL_QUEUE_PROFILING_ENABLE};
use opencl3::context::Context;
use opencl3::device::{get_all_devices, Device, CL_DEVICE_TYPE_GPU};
use opencl3::kernel::{ExecuteKernel, Kernel};
use opencl3::memory::{Buffer, CL_MEM_READ_ONLY, CL_MEM_WRITE_ONLY};
use opencl3::program::Program;
use opencl3::types::{cl_event, cl_float, CL_BLOCKING, CL_NON_BLOCKING};
use opencl3::Result;
use std::ptr;

const PROGRAM_SOURCE: &str = r#"
kernel void saxpy_float (global float* z,
    global float const* x,
    global float const* y,
    float a)
{
    const size_t i = get_global_id(0);
    z[i] = a*x[i] + y[i];
}"#;

const KERNEL_NAME: &str = "saxpy_float";

fn mystery_gpu(verbose: bool) -> Result<()> {
    println!("Execution Mystery Program 5");

    if verbose {
        println!("  Running OpenCL (GPU) kernel...");
    }

    // Find a usable device for this application
    let device_id = *get_all_devices(CL_DEVICE_TYPE_GPU)?
        .first()
        .expect("no device found in platform");
    let device = Device::new(device_id);

    // Create a Context on an OpenCL device
    let context = Context::from_device(&device).expect("Context::from_device failed");

    // Create a command_queue on the Context's device
    let queue = CommandQueue::create_default(&context, CL_QUEUE_PROFILING_ENABLE)
        .expect("CommandQueue::create_default failed");

    // Build the OpenCL program source and create the kernel.
    let program = Program::create_and_build_from_source(&context, PROGRAM_SOURCE, "")
        .expect("Program::create_and_build_from_source failed");
    let kernel = Kernel::create(&program, KERNEL_NAME).expect("Kernel::create failed");

    /////////////////////////////////////////////////////////////////////
    // Compute data

    // The input data
    const ARRAY_SIZE: usize = 1000;
    let ones: [cl_float; ARRAY_SIZE] = [1.0; ARRAY_SIZE];
    let mut sums: [cl_float; ARRAY_SIZE] = [0.0; ARRAY_SIZE];
    for i in 0..ARRAY_SIZE {
        sums[i] = 1.0 + 1.0 * i as cl_float;
    }

    // Create OpenCL device buffers
    let mut x = unsafe {
        Buffer::<cl_float>::create(&context, CL_MEM_READ_ONLY, ARRAY_SIZE, ptr::null_mut())?
    };
    let mut y = unsafe {
        Buffer::<cl_float>::create(&context, CL_MEM_READ_ONLY, ARRAY_SIZE, ptr::null_mut())?
    };
    let z = unsafe {
        Buffer::<cl_float>::create(&context, CL_MEM_WRITE_ONLY, ARRAY_SIZE, ptr::null_mut())?
    };

    // Blocking write
    let _x_write_event = unsafe { queue.enqueue_write_buffer(&mut x, CL_BLOCKING, 0, &ones, &[])? };

    // Non-blocking write, wait for y_write_event
    let y_write_event =
        unsafe { queue.enqueue_write_buffer(&mut y, CL_NON_BLOCKING, 0, &sums, &[])? };

    // a value for the kernel function
    let a: cl_float = 300.0;

    // Use the ExecuteKernel builder to set the kernel buffer and
    // cl_float value arguments, before setting the one dimensional
    // global_work_size for the call to enqueue_nd_range.
    // Unwraps the Result to get the kernel execution event.
    let kernel_event = unsafe {
        ExecuteKernel::new(&kernel)
            .set_arg(&z)
            .set_arg(&x)
            .set_arg(&y)
            .set_arg(&a)
            .set_global_work_size(ARRAY_SIZE)
            .set_wait_event(&y_write_event)
            .enqueue_nd_range(&queue)?
    };

    let mut events: Vec<cl_event> = Vec::default();
    events.push(kernel_event.get());

    // Create a results array to hold the results from the OpenCL device
    // and enqueue a read command to read the device buffer into the array
    // after the kernel event completes.
    let mut results: [cl_float; ARRAY_SIZE] = [0.0; ARRAY_SIZE];
    let read_event =
        unsafe { queue.enqueue_read_buffer(&z, CL_NON_BLOCKING, 0, &mut results, &events)? };

    // Wait for the read_event to complete.
    read_event.wait()?;

    // Output the first and last results
    println!("results front: {}", results[0]);
    println!("results back: {}", results[ARRAY_SIZE - 1]);

    // Calculate the kernel duration, from the kernel_event
    let start_time = kernel_event.profiling_command_start()?;
    let end_time = kernel_event.profiling_command_end()?;
    let duration = end_time - start_time;
    println!("kernel execution duration (ns): {}", duration);

    Ok(())
}
