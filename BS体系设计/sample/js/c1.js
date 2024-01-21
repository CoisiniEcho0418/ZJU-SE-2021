c1 = (function(){
    var factor = 2;
    function innerCalc(a, b)
    {
        var result = a * b * factor;
        return "result is: " + result
    };
    return {"calc": innerCalc};
})()

// function clickme()
// {
//     alert("You clicked me!")
// }
