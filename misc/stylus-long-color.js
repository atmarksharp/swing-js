module.exports = function() {
    var hex = function(n) { return n.toString(16) };

    return function(style) {
        style.define('long', function(color) {
            return '#' + [color.r, color.g, color.b].map(hex).join("");
        });
    }
};