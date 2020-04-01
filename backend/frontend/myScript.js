var gCount = 0
/*
$.get("/data", function(data, status){
    var obj = {};
    obj.bindto="#chart";
    obj.data = {};
    obj.data.columns = [];
    var axis = [];
    console.log(data);
    for(var i=0; i<data.length; i++){
     var count = findItem(axis, data[i].Team);
     if(obj.data.columns[count]===undefined){
        obj.data.columns[count] = [];
        obj.data.columns[count].push(data[i].Team);
        obj.data.columns[count].push(data[i].ranking);
     }else{
        obj.data.columns[count].push(data[i].ranking);
     }
    }
    var chart = c3.generate(obj);
});
*/


var teams_div_season = [];
$.get("/data", function(data, status){
    
    var Division = [""];
        for(var i=0; i<data.length; i++){
            // If element does not exist, add it to the array
            if(Division.indexOf(data[i]["Div"]) === -1){
                Division.push(data[i]["Div"]);
            }
        }
    // Similar way of doing it:
    /*
    var Division = [];
    Division = d3.set(data.map(d => d["Div"])).values();
    Division.unshift("");
    */
    
    // array "data" that will be used for the dropdown selection.
    var subdata = data
    
    // unique values from object property: const unique = [...new Set(subdata.map(item => item.Season))];

    // Array classified by division, season and teams. To be used for dropdown list
    
    Division.forEach(function(element){
        var teams_season = [];
        var tempdata = [];
        tempdata = subdata.filter(x => x.Div === element); // subset of data for given division in "Division"
        var seasons = [];
            // Create an array of unique seasons from data subset. 
            // Can also be done in one line: seasons = d3.set(tempdata.map(d => d["Season"])).values();
            for(var i=0; i<tempdata.length; i++){
                if(seasons.indexOf(tempdata[i]["Season"]) === -1){
                    seasons.push(tempdata[i]["Season"]);
                }
            }

        seasons.forEach(function(element2){ // for each season in data subset
                // select given division and given season:
                tempdata = subdata.filter(x => x.Div === element && x.Season === element2); 
                teams_season[element2] = [...new Set(tempdata.map(item => item.Team))];   
            
        })

        seasons.forEach(function(element2){
            teams_season[element2].unshift("Choose a team");  
        
        })
        // add temorary array "teams_season" containing teams of given division and season 
        // to "teams_div_season" for each division "element":
        teams_div_season[element] =  teams_season
    });
    
    // body corresponds to the parent. Can be changed for a given div (?)
    // var myParent = document.body;
    var myParent = document.getElementById("dropdown");
    // Create data = list of groups
    // var Division = ["E0", "E1", "L1"]
    //Create and append select list
    var title1 = document.createElement("h6");
    title1.className = "Nav_titles"
    title1.innerHTML = "Championship"
    myParent.appendChild(title1);
    var selectList = document.createElement("select");
    selectList.id = "mylist1";
    selectList.name = "mylist1";
    selectList.className = "dropdowns";
    selectList.setAttribute("onchange", "populate(this.id, 'mylist2')");
    myParent.appendChild(selectList); 

    var title2 = document.createElement("h6");
    title2.className = "Nav_titles"
    title2.innerHTML = "Season"
    myParent.appendChild(title2);
    var selectList2 = document.createElement("select");
    selectList2.id = "mylist2";
    selectList2.name = "mylist2";
    selectList2.className = "dropdowns";
    selectList2.setAttribute("onchange", "populate2('mylist1', this.id, 'mylist3')");
    myParent.appendChild(selectList2);
    
    var title3 = document.createElement("h6");
    title3.className = "Nav_titles"
    title3.innerHTML = "Team"
    myParent.appendChild(title3);
    var selectList3 = document.createElement("select");
    selectList3.id = "mylist3";
    selectList3.name = "mylist3";
    selectList3.className = "dropdowns";
    selectList3.setAttribute("onchange", "updateChart('mylist2', this.id)");
    myParent.appendChild(selectList3);


    //Create and append the options
    for (var i = 0; i < Object.keys(teams_div_season).length; i++) {
        var option = document.createElement("option");
        option.value = Object.keys(teams_div_season)[i];
        option.text = Object.keys(teams_div_season)[i];
        selectList.appendChild(option);
    }

});

/*
// D3 HISTOGRAM
// set the dimensions and margins of the graph
var margin = {top: 10, right: 30, bottom: 30, left: 40},
    width = 460 - margin.left - margin.right,
    height = 400 - margin.top - margin.bottom;

// append the svg object to the body of the page
var svg = d3.select("#Chart2")
  .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

// get the data
d3.csv("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/data_doubleHist.csv", function(data) {

  // X axis: scale and draw:
  var x = d3.scaleLinear()
      .domain([-4,9])     // can use this instead of 1000 to have the max of data: d3.max(data, function(d) { return +d.price })
      .range([0, width]);
  svg.append("g")
      .attr("transform", "translate(0," + height + ")")
      .call(d3.axisBottom(x));

  // set the parameters for the histogram
  var histogram = d3.histogram()
      .value(function(d) { return +d.value; })   // I need to give the vector of value
      .domain(x.domain())  // then the domain of the graphic
      .thresholds(x.ticks(40)); // then the numbers of bins

  // And apply twice this function to data to get the bins.
  var bins1 = histogram(data.filter( function(d){return d.type === "variable 1"} ));
  var bins2 = histogram(data.filter( function(d){return d.type === "variable 2"} ));

  // Y axis: scale and draw:
  var y = d3.scaleLinear()
      .range([height, 0]);
      y.domain([0, d3.max(bins1, function(d) { return d.length; })]);   // d3.hist has to be called before the Y axis obviously
  svg.append("g")
      .call(d3.axisLeft(y));

  // append the bars for series 1
  svg.selectAll("rect")
      .data(bins1)
      .enter()
      .append("rect")
        .attr("x", 1)
        .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; })
        .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
        .attr("height", function(d) { return height - y(d.length); })
        .style("fill", "#69b3a2")
        .style("opacity", 0.6)

  // append the bars for series 2
  svg.selectAll("rect2")
      .data(bins2)
      .enter()
      .append("rect")
        .attr("x", 1)
        .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; })
        .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
        .attr("height", function(d) { return height - y(d.length); })
        .style("fill", "#404080")
        .style("opacity", 0.6)

  // Handmade legend
  svg.append("circle").attr("cx",300).attr("cy",30).attr("r", 6).style("fill", "#69b3a2")
  svg.append("circle").attr("cx",300).attr("cy",60).attr("r", 6).style("fill", "#404080")
  svg.append("text").attr("x", 320).attr("y", 30).text("variable A").style("font-size", "15px").attr("alignment-baseline","middle")
  svg.append("text").attr("x", 320).attr("y", 60).text("variable B").style("font-size", "15px").attr("alignment-baseline","middle")

});
*/
function populate(l1, l2){
    var l1 = document.getElementById(l1);
    var l2 = document.getElementById(l2);
    
    l2.innerHTML = "";

    var optionArray = [];
    Object.keys(teams_div_season).forEach(function(opt){
        if(l1.value == opt){
            var optionArr = [];
            optionArr = Object.keys(teams_div_season[opt]);
            optionArray = optionArr.map((e) => e + "|" + e);
        } 
    });
        
    for(var option in optionArray){
        var pair = optionArray[option].split("|");
        var newOption = document.createElement("option"); /* createElement is creating a new HTML element
        for example document.createElement("div") to create a new div*/
        newOption.value = pair[0];
        newOption.innerHTML = pair[1];
        l2.options.add(newOption);
    }
}

function populate2(l1, l2, l3){
    var l1 = document.getElementById(l1);
    var l2 = document.getElementById(l2);
    var l3 = document.getElementById(l3);

    l3.innerHTML = "";

    var optionArray2 = [];
    Object.keys(teams_div_season).forEach(function(elem){
        if(l1.value == elem){
            Object.keys(teams_div_season[elem]).forEach(function(opt2){
                if(l2.value == opt2){
                    var optionArr2 = [];
                    optionArr2 = teams_div_season[elem][opt2];
                    /* var lower_case2 = [];
                    lower_case2 = optionArr2.map(function (val) { return val.toLowerCase(); }); */
                    optionArray2 = optionArr2.map((e) => e + "|" + e);
                }
            });
        } 
    });
        
    for(var option in optionArray2){
        var pair = optionArray2[option].split("|");
        var newOption = document.createElement("option"); /* createElement is creating a new HTML element
        for example document.createElement("div") to create a new div*/
        newOption.value = pair[0];
        newOption.innerHTML = pair[1];
        l3.options.add(newOption);
    }
}


function updateChart(mySeason, myTeam) {
    var mySeason = document.getElementById(mySeason).value;
    var myTeam = document.getElementById(myTeam).value;

    $.get("/data", function(data, status){
        gCount = 0
        count = 0
        var obj = {};
        data = data.filter(x => x.Season === mySeason && x.Team === myTeam);
        obj.bindto="#Chart1";
        obj.data = {};
        obj.data.columns = [];
        obj.axis = {};
        obj.axis.y = {};
        obj.axis.y.inverted = "true";
        obj.axis.y.max = teams_div_season[data[0]["Div"]][mySeason].length;
        obj.axis.y.min = 1;
        var axis = [];
        console.log(data);
        for(var i=0; i<data.length; i++){
         var count = findItem(axis, data[i].Team);
         if(obj.data.columns[count]===undefined){
            obj.data.columns[count] = [];
            obj.data.columns[count].push(data[i].Team);
            obj.data.columns[count].push(data[i].ranking);

         }else{
            obj.data.columns[count].push(data[i].ranking);
         }
        }
        var chart = c3.generate(obj);
    });
}

function findItem(axis, item){
    if(axis.length>0){
        for(i=0; i<axis.length; i++){
            if(axis[i].id===item){
                return axis[i].count;
            }
        }
    }else{
        axis.push({
            id: item,
            count: gCount
        });
        gCount++;
        return gCount-1
    }
    
}


