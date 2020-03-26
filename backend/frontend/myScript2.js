get("/data", function(data, status){
    var obj = {};
    obj.bindto="#chart";
    obj.data = {};
    obj.data.columns = [];
    var axis = [];
    console.log(data);
    var temp = [];
    var temp1 =[];
    var temp2 = [];
    temp.push("Arsenal");
    temp1.push("Norwich");
    temp2.push("Watford");
for(var i=0; i<data.length; i++){
        if(axis.indexOf(data[i].HomeTeam === -1)){
            axis.indexOf[i].push(data[i].HomeTeam)
        }
        if(data[i].HomeTeam === "Arsenal"){
            temp.push(data[i].HomeTeamRank)
        }

        if(data[i].HomeTeam === "Norwich"){
            temp1.push(data[i].HomeTeamRank)
        }

        if(data[i].HomeTeam === "Watford"){
            temp2.push(data[i].HomeTeamRank)
        }
    }
    obj.data.columns.push(temp);
    obj.data.columns.push(temp1);
    obj.data.columns.push(temp2);
    var chart = c3.generate(obj);
  });