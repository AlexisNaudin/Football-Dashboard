var gCount = 0

d3.csv("https://raw.githubusercontent.com/AlexisNaudin/Football-Dashboard/master/backend/Football_DB/Teams_Result_DB.csv").then(function(datad3) {
    console.log(datad3[0]);
  });
var teams_div_season = [];
$.get("/data", function(data, status){
    
    var Division = [];
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

        // add temorary array "teams_season" containing teams of given division and season 
        // to "teams_div_season" for each division "element":
        teams_div_season[element] =  teams_season
    });
    
    // body corresponds to the parent. Can be changed for a given div (?)
    // var myParent = document.body;
    var myParent = document.getElementById("dropdown");
    var selectList = document.getElementById("mylist1");

    var option1 = document.createElement("option");
    option1.value = "Choose a League";
    option1.text = "Choose a League";
    selectList.appendChild(option1);
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
    
    var option2 = document.createElement("option");
    option2.value = "Choose a Season";
    option2.text = "Choose a Season";
    l2.options.add(option2);

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
        
    var option3 = document.createElement("option");
    option3.value = "Choose a Team";
    option3.text = "Choose a Team";
    l3.options.add(option3);

    for(var option in optionArray2){
        var pair = optionArray2[option].split("|");
        var newOption = document.createElement("option"); /* createElement is creating a new HTML element
        for example document.createElement("div") to create a new div*/
        newOption.value = pair[0];
        newOption.innerHTML = pair[1];
        l3.options.add(newOption);
    }
}


function updateData(mySeason, myTeam) {
    var mySeason = document.getElementById(mySeason).value;
    var myTeam = document.getElementById(myTeam).value;

    // D3 HISTOGRAM
    const margin = {top: 20, right: 20, bottom: 20, left: 45},
    width = 550 - margin.left - margin.right,
    height = 260 - margin.top - margin.bottom;
    
    const x = d3.scaleBand()
    .range([0, width])
    .padding(0.1);
    
    const y = d3.scaleLinear()
    .range([height, 0]);
    
    d3.select("#Chart2").select("svg").remove(); 
    const svg = d3.select("#Chart2").append("svg")
    .attr("id", "svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    
    
    
    const div = d3.select("body").append("div")
    .attr("class", "tooltip")         
    .style("opacity", 0);


    var Team_rank = [];
    var Results = [];

    $.get("/data", function(data, status){
        data = data.filter(x => x.Team === myTeam && x.Season === mySeason);
        Team_rank = data[data.length-1]["ranking"];


        // Last Results
        var lastResult = ["Res1", "Res2", "Res3", "Res4", "Res5", "Res6"];
        lastResult.forEach(function(Res, index){
            if(data[data.length -1 -index] == undefined){
                document.getElementById(Res).innerHTML = "-";
                document.getElementById(Res).className = "ResNA";
            } else {
                if(data[data.length -1 -index]["Outcome"] == "Win"){
                    document.getElementById(Res).innerHTML = "W";
                    document.getElementById(Res).className = "ResW";
                } else if (data[data.length -1 -index]["Outcome"] == "Draw") {
                    document.getElementById(Res).innerHTML = "D";
                    document.getElementById(Res).className = "ResD";
                } else if (data[data.length -1 -index]["Outcome"] == "Loss"){
                    document.getElementById(Res).innerHTML = "L";
                    document.getElementById(Res).className = "ResL";
                } else {
                    document.getElementById(Res).innerHTML = "-";
                    document.getElementById(Res).className = "ResNA";
                }
            }  
        });
        
        // Wins, draws and losses frequencies
        countWins = 0;
        countDraws = 0;
        countLosses = 0;
        for(var i=0; i<data.length; i++){
            Results.push(data[i]["Outcome"])
            if(data[i]["Outcome"] == "Win"){
                countWins++;
            } else if (data[i]["Outcome"] == "Draw") {
                countDraws++;
            } else if (data[i]["Outcome"] == "Loss"){
                countLosses++;
            }
        }

        // Statistics
        Shots = 0;
        countShots = 0;
        Shots_target = 0;
        countShots_target = 0,
        Goals_scored = 0;
        countGoals_scored = 0;
        Goals_against = 0;
        countGoals_against = 0;
        Yellow_cards = 0;
        Red_cards = 0;
        Corners = 0;
        countCorners = 0;
        for(var i = 0; i<data.length; i++){
            if(data[i]["Shots"] == "NA" || Number(data[i]["Shots"]) == NaN){
            } else {
                Shots = Shots + Number(data[i]["Shots"]);
                countShots++;
            }
            
            if(data[i]["Shots_target"] == "NA" || Number(data[i]["Shots_target"]) == NaN){
            } else {
                Shots_target = Shots_target + Number(data[i]["Shots_target"]);
                countShots_target++;
            }

            if(data[i]["Goals_scored"] == "NA" || Number(data[i]["Goals_scored"]) == NaN){
            } else {
                Goals_scored = Goals_scored + Number(data[i]["Goals_scored"]);
                countGoals_scored++;
            }
            
            if(data[i]["Goals_against"] == "NA" || Number(data[i]["Goals_against"]) == NaN){
            } else {
                Goals_against = Goals_against + Number(data[i]["Goals_against"]);
                countGoals_against++;
            }

            if(data[i]["Yellow_cards"] == "NA" || Number(data[i]["Yellow_cards"]) == NaN){
            } else {
                Yellow_cards = Yellow_cards + Number(data[i]["Yellow_cards"]);
            }

            if(data[i]["Red_cards"] == "NA" || Number(data[i]["Red_cards"]) == NaN){
            } else {
                Red_cards = Red_cards + Number(data[i]["Red_cards"]);
            }
            
            if(data[i]["Corners"] == "NA" || Number(data[i]["Corners"]) == NaN){
            } else {
                Corners = Corners + Number(data[i]["Corners"]);
                countCorners++;
            }
                       
        }
                 
        gCount = 0
        count = 0
        var obj = {};
        obj.bindto="#Chart1";
        obj.data = {};
        obj.data.columns = [];
        obj.axis = {};
        obj.axis.y = {};
        obj.axis.y.inverted = "true";
        obj.axis.y.max = teams_div_season[data[0]["Div"]][mySeason].length;
        obj.axis.y.min = 1;
        obj.title = {};
        obj.title.text = "Evolution of " + myTeam + "'s Ranking";
        obj.transition = {};
        obj.transition.duration = 2000;
        obj.oninit = function () {
            this.main.append('rect')
                .style('fill', '#181818')
                .attr('x', 0.5)
                .attr('y', -0.5)
                .attr('width', this.width)
                .attr('height', this.height)
              .transition().duration(4000)
                .attr('x', this.width)
                .attr('width', 0)
              .remove();
        } 
        
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

        Team_ranking = document.getElementById("Team_Rank");

        if(Team_rank == 1 || Team_rank == 21){
            Team_ranking.innerHTML = Team_rank + "<sup>st</sup>";
        } else if (Team_rank == 2 || Team_rank == 22){
            Team_ranking.innerHTML = Team_rank + "<sup>nd</sup>";
        } else if (Team_rank == 3 || Team_rank == 23){
            Team_ranking.innerHTML = Team_rank + "<sup>rd</sup>";
        } else {
            Team_ranking.innerHTML = Team_rank + "<sup>th</sup>";
        }
        
        document.getElementById("Team_Ranking").appendChild(Team_ranking);

        nb_wins = document.getElementById("nbWins");
        pct_wins = document.getElementById("pctWins");
        nb_wins.innerHTML = countWins;
        pct_wins.innerHTML = "(" + Math.round((countWins/data.length)*1000)/10 + "% )";
        document.getElementById("Wins").appendChild(nb_wins);
        document.getElementById("Wins").appendChild(pct_wins);
        nb_draws = document.getElementById("nbDraws");
        pct_draws = document.getElementById("pctDraws");
        nb_draws.innerHTML = countDraws;
        pct_draws.innerHTML = "(" + Math.round((countDraws/data.length)*1000)/10 + "% )";
        document.getElementById("Draws").appendChild(nb_draws);
        document.getElementById("Draws").appendChild(pct_draws);
        nb_losses = document.getElementById("nbLosses");
        pct_losses = document.getElementById("pctLosses");
        nb_losses.innerHTML = countLosses;
        pct_losses.innerHTML = "(" + Math.round((countLosses/data.length)*1000)/10 + "% )";
        document.getElementById("Losses").appendChild(nb_losses);
        document.getElementById("Losses").appendChild(pct_losses);

        avg_Shots = document.getElementById("Avg_shots_per_game");
        avg_Shots.innerHTML = Math.round((Shots/countShots)*10)/10;
        document.getElementById("Avg_shots").appendChild(avg_Shots);
 
        avg_Shots_target = document.getElementById("Avg_shots_target_per_game");
        avg_Shots_target.innerHTML = Math.round((Shots_target/countShots_target)*10)/10;
        document.getElementById("Avg_shots_target").appendChild(avg_Shots_target);
        
        nbGoals_scored = document.getElementById("nb_Goals_scored");
        nbGoals_scored.innerHTML = Goals_scored;
        document.getElementById("Goals_scored").appendChild(nbGoals_scored);

        nbGoals_against = document.getElementById("nb_Goals_conceeded");
        nbGoals_against.innerHTML = Goals_against;
        document.getElementById("Goals_conceeded").appendChild(nbGoals_against);

        nbYellow_cards = document.getElementById("nbYellow");
        nbYellow_cards.innerHTML = Yellow_cards;
        document.getElementById("Yellow_cards").appendChild(nbYellow_cards);

        nbRed_cards = document.getElementById("nbRed");
        nbRed_cards.innerHTML = Red_cards;
        document.getElementById("Red_cards").appendChild(nbRed_cards);

        nbCorners = document.getElementById("Avg_corner_per_game");
        nbCorners.innerHTML = Math.round((Corners/countCorners)*10)/10;
        document.getElementById("Corners").appendChild(nbCorners);

        // D3 Histogram
        // data
        var Shots_hist = [];
        var Shots_target_hist = [];

        for(var i=0; i<data.length; i++){
            obj = {};
            obj2 = {};
            obj.Matchday = i;
            obj2.Matchday = i;
            obj.shots = data[i]["Shots"];
            obj2.shots_target = data[i]["Shots_target"];
            Shots_hist.push(obj);
            Shots_target_hist.push(obj2);            
        }

        Shots_hist.forEach(function(d) {
            d.shots = +d.shots;
        });

        Shots_target_hist.forEach(function(d) {
            d.shots_target = +d.shots_target;
        });

            // Mise en relation du scale avec les données de notre fichier
            // Pour l'axe X, c'est la liste des pays
            // Pour l'axe Y, c'est le max des populations
            x.domain(Shots_hist.map(function(d) { return d.Matchday; }));
            y.domain([0, d3.max(Shots_hist, function(d) { return d.shots; })]);

            // Ajout de l'axe X au SVG
            // Déplacement de l'axe horizontal et du futur texte (via la fonction translate) au bas du SVG
            // Selection des noeuds text, positionnement puis rotation
            svg.append("g")
                .attr("transform", "translate(0," + height + ")")
                .call(d3.axisBottom(x).tickSize(0).tickValues(x.domain().filter((d, i) => d % 5 === 0)))
                .selectAll("text")	
                    .style("text-anchor", "end")
                    .attr("dy", ".8em")
                    //.attr("dx", "-.8em")
                    //.attr("transform", "rotate(-65)");
            
            // Ajout de l'axe Y au SVG avec 6 éléments de légende en utilisant la fonction ticks (sinon D3JS en place autant qu'il peut).
            svg.append("g")
                .call(d3.axisLeft(y).ticks(6));
        
            // Ajout des bars en utilisant les données de notre fichier data.tsv
            // La largeur de la barre est déterminée par la fonction x
            // La hauteur par la fonction y en tenant compte de la population
            // La gestion des events de la souris pour le popup
            svg.selectAll(".bar")
                .data(Shots_hist)
            .enter().append("rect")
                .attr("class", "bar")
                .attr("x", function(d) { return x(d.Matchday); })
                .attr("width", x.bandwidth())
                .attr("y", function(d) { return y(0); })
                .attr("height", function(d) { return height - y(0); })
                .style("fill", "#69b3a2")
                .style("opacity", 0.6)					
                .on("mouseover", function(d) {
                    div.transition()        
                        .duration(200)      
                        .style("opacity", .9);
                    div.html("Shots : " + d.shots)
                        .style("left", (d3.event.pageX + 10) + "px")     
                        .style("top", (d3.event.pageY - 50) + "px");
                })
                .on("mouseout", function(d) {
                    div.transition()
                        .duration(500)
                        .style("opacity", 0);
                })
                .transition()
                .duration(800)
                .attr("y", function(d) { return y(d.shots); })
                .attr("height", function(d) { return height - y(d.shots); })
                .delay(function(d,i){console.log(i) ; return(i*100)})

                svg.selectAll(".bar2")
                .data(Shots_target_hist)
            .enter().append("rect")
                .attr("class", "bar")
                .attr("x", function(d) { return x(d.Matchday); })
                .attr("width", x.bandwidth())
                .attr("y", function(d) { return y(0); })
                .attr("height", function(d) { return height - y(0); })
                .style("fill", "#404080")
                .style("opacity", 0.6)					
                .on("mouseover", function(d) {
                    div.transition()        
                        .duration(200)      
                        .style("opacity", .9);
                    div.html("Shots on target : " + d.shots_target)
                        .style("left", (d3.event.pageX + 10) + "px")     
                        .style("top", (d3.event.pageY - 50) + "px");
                })
                .on("mouseout", function(d) {
                    div.transition()
                        .duration(500)
                        .style("opacity", 0);
                })
                .transition()
                .duration(800)
                .attr("y", function(d) { return y(d.shots_target); })
                .attr("height", function(d) { return height - y(d.shots_target); })
                .delay(function(d,i){console.log(i) ; return(i*25)})
                    
        /* // Handmade legend
        svg.append("circle").attr("cx",300).attr("cy",30).attr("r", 6).style("fill", "#69b3a2")
        svg.append("circle").attr("cx",300).attr("cy",60).attr("r", 6).style("fill", "#404080")
        svg.append("text").attr("x", 320).attr("y", 30).text("variable A").style("font-size", "15px").attr("alignment-baseline","middle")
        svg.append("text").attr("x", 320).attr("y", 60).text("variable B").style("font-size", "15px").attr("alignment-baseline","middle")
        */
    });
    
    Team_header = document.getElementById("Team_Name");
    Team_header.innerHTML = document.getElementById("mylist3").value + " - <small>" + document.getElementById("mylist2").value + "</small>";
    document.getElementById("Team_header").appendChild(Team_header);
    
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

