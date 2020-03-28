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
     var count = findItem(axis, data[i].HomeTeam);
     if(obj.data.columns[count]===undefined){
        obj.data.columns[count] = [];
        obj.data.columns[count].push(data[i].HomeTeam);
        obj.data.columns[count].push(data[i].HomeTeamRank);
     }else{
        obj.data.columns[count].push(data[i].HomeTeamRank);
     }
    }
    var chart = c3.generate(obj);
});
*/

var teams_div_season = [];
$.get("/data", function(data, status){
    
    var Division = [""];
    var Seasons = [""];
    var Teams = [""];
    var elements = [Division, Seasons, Teams]
    var associated = ["Div", "Season", "HomeTeam"]
    elements.forEach(function(element, index){
        for(var i=0; i<data.length; i++){
            // If element does not exist, add it to the array
            if(element.indexOf(data[i][associated[index]]) === -1){
                element.push(data[i][associated[index]]);
            }
        }
    });
    
    // subset of the data keeping only properties Div, Season and HomeTeam of objects in
    // array "data" that will be used for the dropdown selection.
    var subdata = data
    const dropdownData = subdata.map(({Div, Season, HomeTeam}) => ({
        Div, Season, HomeTeam
    }));
    
    // unique values from object property: const unique = [...new Set(subdata.map(item => item.Season))];

    // Array classified by division, season and teams. To be used for dropdown list
    
    Division.forEach(function(element){
        var teams_season = [];
        var tempdata = [];
        tempdata = subdata.filter(x => x.Div === element); // subset of data for given division in "Division"
        var seasons = [];
            for(var i=0; i<tempdata.length; i++){
                // Create an array of unique seasons from data subset
                if(seasons.indexOf(tempdata[i]["Season"]) === -1){
                    seasons.push(tempdata[i]["Season"]);
                }
            }
        seasons.forEach(function(element2){ // for each season in data subset
            for(var i=0; i<dropdownData.length; i++){
                // select given division and given season:
                tempdata = subdata.filter(x => x.Div === element && x.Season === element2); 
                teams_season[element2] = [...new Set(tempdata.map(item => item.HomeTeam))];     
            }
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
    var title1 = document.createElement("h4");
    title1.innerHTML = "Championship"
    myParent.appendChild(title1);
    var selectList = document.createElement("select");
    selectList.id = "mylist1";
    selectList.name = "mylist1";
    selectList.setAttribute("onchange", "populate(this.id, 'mylist2')");
    myParent.appendChild(selectList);

    var title2 = document.createElement("h4");
    title2.innerHTML = "Season"
    myParent.appendChild(title2);
    var selectList2 = document.createElement("select");
    selectList2.id = "mylist2";
    selectList2.name = "mylist2";
    selectList2.setAttribute("onchange", "populate2('mylist1', this.id, 'mylist3')");
    myParent.appendChild(selectList2);
    
    var title3 = document.createElement("h4");
    title3.innerHTML = "Choose your team"
    myParent.appendChild(title3);
    var selectList3 = document.createElement("select");
    selectList3.id = "mylist3";
    selectList3.name = "mylist3";
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
        data = data.filter(x => x.Season === mySeason && x.HomeTeam === myTeam);
        obj.bindto="#Chart1";
        obj.data = {};
        obj.data.columns = [];
        var axis = [];
        console.log(data);
        for(var i=0; i<data.length; i++){
         var count = findItem(axis, data[i].HomeTeam);
         if(obj.data.columns[count]===undefined){
            obj.data.columns[count] = [];
            obj.data.columns[count].push(data[i].HomeTeam);
            obj.data.columns[count].push(data[i].HomeTeamRank);
         }else{
            obj.data.columns[count].push(data[i].HomeTeamRank);
         }
        }
        var chart = c3.generate(obj);
    });
}


function findItem(axis, item){
    for(i=0; i<axis.length; i++){
        if(axis[i].id===item){
            return axis[i].count;
        }
    }
    axis.push({
        id: item,
        count: gCount
    });
    gCount++;
    return gCount-1
}


