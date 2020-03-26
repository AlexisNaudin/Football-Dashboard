$('mylist').editableSelect();

        /*

        // Create data = list of groups
        var allGroup = ["yellow", "blue", "red", "green", "purple", "black"]

        // Initialize the button
        var dropdownButton = d3.select("#Chart2")
        .append('select').attr("id", "mylist1")

        // add the options to the button
        dropdownButton // Add a button
        .selectAll('myOptions') // Next 4 lines add 6 options = 6 colors
            .data(allGroup)
        .enter()
            .append('option')
        .text(function (d) { return d; }) // text showed in the menu
        .attr("value", function (d) { return d; }) // corresponding value returned by the button
        
        */


    function populate(l2, l3){
        var l2 = document.getElementById(l2);
        var l3 = document.getElementById(l3);
        

        l3.innerHTML = "";
    
        if(l2.value == "Premier League"){
            var optionArray = ["|", "20152016|20152016", "20162017|20162017", "20172018|20172018"];
        } else if(l2.value == "Ligue 1"){
            var optionArray = ["|", "20162017|20162017", "20172018|20172018"];
        }

        for(var option in optionArray){
            var pair = optionArray[option].split("|");
            var newOption = document.createElement("option"); /* createElement is creating a new HTML element
            for example document.createElement("div") to create a new div*/
            newOption.value = pair[0];
            newOption.innerHTML = pair[1];
            l3.options.add(newOption);
        }
    }

    function populate2(l3, l4){
        var l3 = document.getElementById(l3);
        var l4 = document.getElementById(l4);

        l4.innerHTML = "";

    if(l3.value == "20152016"){
        var optionArray2 = ["|", "arsenal|Arsenal", "watford|Watford", "burnley|Burnley"];
    } else if(l3.value == "20172018"){
        var optionArray2 = ["|", "marseille|Marseille", "lyon|Lyon", "toulouse|Toulouse"];
    }
    
    for(var option in optionArray2){
        var pair = optionArray2[option].split("|");
        var newOption2 = document.createElement("option"); /* createElement is creating a new HTML element
        for example document.createElement("div") to create a new div*/
        newOption2.value = pair[0];
        newOption2.innerHTML = pair[1];
        l4.options.add(newOption2);
    }
}