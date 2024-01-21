common3 = (function() {
    factor = 2;
    function calc(a, b)
    {
        var result = (a + b) * factor
        return "result is: " + result
    }
    return {"calc": calc};
}());