var jframe;
var jlabel;

Swing.ready(function(){
  jframe = new JFrame();
  jlabel = new JLabel("hello");

  jframe
    .title("hello")
    .size("300px","200px")
    .add(jlabel)
    .visible(true)
});

