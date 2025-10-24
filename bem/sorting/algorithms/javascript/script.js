/*jshint esversion: 8 */
/* Axam - 24.05.2023 */

var container = document.getElementById("array");

// To start the sorting algorithm
var isSorting = {
    v: false,
    set value(val){
        this.v = val;
        sortKnownBtn.disabled = val;
        sortBtn.disabled = val;
        startBtn.disabled = val;
        startOptiBtn.disabled = val;
    },
    get value(){
        return this.v;
    }
}
var startBtn = document.getElementById("sortStart");
startBtn.addEventListener('click', event => {
    if(isSorting.value === false){
        isSorting.value = true;
        resetData();
        BubbleSort();
    }
});
var startOptiBtn = document.getElementById("sortOptiStart");
startOptiBtn.addEventListener('click', event => {
    if(isSorting.value === false){
        isSorting.value = true;
        resetData();
        BubbleSort(true);
    }
});
var startSortPerf = document.getElementById("sortPerf");
startSortPerf.addEventListener('click', event => {
    if(isSorting.value === false){
        isSorting.value = true;
        bubbleSortPerf();
    }
});
var startSortPerfOpti = document.getElementById("sortPerfOpti");
startSortPerfOpti.addEventListener('click', event => {
    if(isSorting.value === false){
        isSorting.value = true;
        bubbleSortPerf(true);
    }
});

// To regenerate data
var sortKnownBtn = document.getElementById("sortGenerateKnown");
sortKnownBtn.addEventListener('click', event => {
    if(isSorting.value === false){
      generatearray(true);
    }
});
var sortBtn = document.getElementById("sortGenerate");
sortBtn.addEventListener('click', event => {
    if(isSorting.value === false){
      generatearray();
    }
});

// To tweak settings
var sliderSwapShowDelay = document.getElementById("rangeSwapShowDelay");
var textSwapShowDelay = document.getElementById("textSwapShowDelay");
sliderSwapShowDelay.oninput = function() {
  textSwapShowDelay.innerHTML = this.value.padStart(3,"0") + " [ms]";
}
sliderSwapShowDelay.value = 300;
textSwapShowDelay.innerHTML = sliderSwapShowDelay.value + " [ms]";

var sliderSwapAnimDelay = document.getElementById("rangeSwapAnimDelay");
var textSwapAnimDelay = document.getElementById("textSwapAnimDelay");
sliderSwapAnimDelay.oninput = function() {
  textSwapAnimDelay.innerHTML = this.value.padStart(3,"0") + " [ms]";
}
sliderSwapAnimDelay.value = 100;
textSwapAnimDelay.innerHTML = sliderSwapAnimDelay.value + " [ms]";

function resetData(){
    var blocks = document.querySelectorAll(".block");
    for (var i = 0; i < blocks.length; i += 1) {
        blocks[i].style.backgroundColor = "#6b5b95";
    }
}

// Function to generate the array of blocks
function generatearray(predef = false) {
    console.log("Generating new data");
    const known_data = [99, 2, 85, 12, 76, 43, 56, 24, 36, 69, 7, 91, 18, 63, 41, 29, 84, 55, 31, 94];
    // Clear data
    container.innerHTML = "";
    for (var i = 0; i < 20; i++) {

        if(predef){
            var value = known_data[i];
        }
        else{
            // Return a value from 1 to 100 (both inclusive)
            var value = Math.ceil(Math.random() * 100);
        }

        // Creating element div
        var array_ele = document.createElement("div");

        // Adding class 'block' to div
        array_ele.classList.add("block");

        // Adding style to div
        array_ele.style.height = `${value * 3}px`;
        array_ele.style.transform = `translate(${i * 30}px)`;

        // Creating label element for displaying
        // size of particular block
        var array_ele_label = document.createElement("label");
        array_ele_label.classList.add("block_id");
        array_ele_label.innerText = value;

        // Appending created elements to index.html
        array_ele.appendChild(array_ele_label);
        container.appendChild(array_ele);
    }
}

// Promise to swap two blocks
function swap(el1, el2) {
    return new Promise((resolve) => {

        // For exchanging styles of two blocks
        var temp = el1.style.transform;
        el1.style.transform = el2.style.transform;
        el2.style.transform = temp;

        window.requestAnimationFrame(function () {

            // For waiting for .25 sec
            setTimeout(() => {
                container.insertBefore(el2, el1);
                resolve();
            }, sliderSwapAnimDelay.value);
    });
});
}

// Asynchronous BubbleSort function
async function BubbleSort(useOpti = false) {
    var blocks = document.querySelectorAll(".block");
    console.log("Starting bubble sort");
    // BubbleSort Algorithm
    var isSwapped = false;
    for (var i = 0; i < blocks.length; i += 1) {
        isSwapped = false;
        for (var j = 0; j < blocks.length - i - 1; j += 1) {

            // To change background-color of the
            // blocks to be compared
            blocks[j].style.backgroundColor = "#FF4949";
            blocks[j + 1].style.backgroundColor = "#FF4949";

            // To wait for given delay
            await new Promise((resolve) =>
              setTimeout(() => {
                  resolve();
              }, sliderSwapShowDelay.value)
            );

            var value1 = Number(blocks[j].childNodes[0].innerHTML);
            var value2 = Number(blocks[j + 1]
                .childNodes[0].innerHTML);

            // To compare value of two blocks
            if (value1 > value2) {
                await swap(blocks[j], blocks[j + 1]);
                blocks = document.querySelectorAll(".block");
                isSwapped = true;
            }

            // Changing the color to the previous one
            blocks[j].style.backgroundColor = "#6b5b95";
            blocks[j + 1].style.backgroundColor = "#6b5b95";
        }

        if(!isSwapped && useOpti) {
            for (var j = 0; j < blocks.length - i; j += 1) {
                blocks[j].style.backgroundColor = "#E2DB0E";
            }
            break;
        }

        //changing the color of greatest element
        //found in the above traversal
        blocks[blocks.length - i - 1]
            .style.backgroundColor = "#13CE66";
    }
    console.log("Sorting done");
    isSorting.value = false;
}


// Asynchronous BubbleSort function
function bubbleSortPerf(useOpti = false) {
    if(document.getElementById("taBubblePerfValues").value == ""){
        alert("Please select a data file first.");
        isSorting.value = false;
        return;
    }
    // Get data
    var dta = document.querySelector("#taBubblePerfValues").value.split('\n');
    console.log("Beginning sort test on " + dta.length + " elements");

    const tStart = performance.now();
    var i, j;
    var len = dta.length;
    var isSwapped = false;
    for (i = 0; i < len; i++) {
        isSwapped = false;
        for (j = 0; j < len; j++) {
            if (dta[j] > dta[j + 1]) {
                var temp = dta[j]
                dta[j] = dta[j + 1];
                dta[j + 1] = temp;
                isSwapped = true;
            }
        }
        if (useOpti && !isSwapped) {
            console.log('Is sorted');
            break;
        }
    }
    const tEnd = performance.now();

    document.querySelector("#textBubblePerf").innerHTML = (tEnd-tStart) + " [ms]";

    // Print the array
    console.log("Bubble sort took " + (tEnd-tStart) + " [ms] (from " +
        tStart + " to " + tEnd + ")");
    isSorting.value = false;
}

function readSingleFile(evt) {
    var f = evt.target.files[0]; 
    if (f) {
      var r = new FileReader();
      r.onload = function(e) { 
          var contents = e.target.result;
        alert( "Got file:\n" 
              +"  - name: " + f.name + "\n"
              +"  - type: " + f.type + "\n"
              +"  - size: " + f.size + " bytes\n"
              +"  - starts with: " + contents.substr(1, contents.indexOf("\n"))
        );  
        document.getElementById('taBubblePerfValues').value = contents;
      }
      r.readAsText(f);
    } else { 
      alert("Failed to load file");
    }
}
document.getElementById('bubblePerfFileInput').addEventListener('change', readSingleFile, false);

// Calling generatearray function
generatearray();
