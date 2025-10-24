object JDoodle {
    
  // Reads file and create memory array
  def readFile(filename: String): Array[Int] = {
    val bufferedSource = io.Source.fromFile(filename)
    val lines = (for (line <- bufferedSource.getLines()) yield line.toInt).toArray
    bufferedSource.close
    lines
  }

  // Execute the given sort function with timings check
  def executeSort(filename: String, sortName: String, func: (Array[Int]) => Array[Int]): Unit = {
    var data = readFile(filename);
    var start = System.currentTimeMillis();
    var sorted = func(data);
    var end = System.currentTimeMillis();
    
    printf("\n%s sorted in %d [ms]\nResult of up to the 20 first values:\n * ", sortName, end-start);
    var i = 0;
    while(i < 20 && i < sorted.length){
      printf("%d ", sorted(i));
      i += 1;
    }
    printf("\nThe data are %s sorted\n", if(checkValues(sorted)) "correctly" else "incorrectly");
  }
  
  // Test if the array is correctly sorted
  def checkValues(data: Array[Int]): Boolean = {
    var last = data(0);
    var dta = 0;
    for(dta <- data){
        if (dta < last){return false;}
        last = dta;
    }
    return true;
  }

  // A bubble sort example
  def bubbleSort(data: Array[Int]): Array[Int] = {
    var i: Int = 0
    var j: Int = 0
    var t: Int = 0

    while (i < data.length) {
      j = data.length - 1;
      while (j > i) {
        if (data(j) < data(j - 1)) {
          t = data(j);
          data(j) = data(j - 1);
          data(j - 1) = t;
        }
        j = j - 1
      }
      i = i + 1
    }
    data
  }
  
  // Your sort algorithm
  def mySortAlgorithm(data: Array[Int]): Array[Int] = {
    data
  }

  def main(args: Array[String]) {
    // Modify data file here based on your uploaded files
    val dataFile = "/uploads/10k.txt";
    
    // Sort array using bubble sort.
    executeSort(dataFile, "Bubble Sort", bubbleSort);
    // Sort array using your method.
    executeSort(dataFile, "My sort algorithm", mySortAlgorithm);
  }
}