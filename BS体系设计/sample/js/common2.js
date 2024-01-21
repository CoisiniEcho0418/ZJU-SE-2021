common2 = new Object({
    factor : 2,
    calc : function(a, b)
    {
        var result = a * b * this.factor
        return "result is: " + result
    }
})