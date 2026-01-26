<style>
.hidden-fb {
opacity: 0;
display: none;
}
.links > a {
display: none;
}
.links > a:first-child {
display: block;
}
.btn {
margin-top: 5px;
}
/* Style the tab */
div.tab {
overflow: hidden;
border: 1px solid #ccc;
background-color: #f1f1f1;
}
/* Style the buttons inside the tab */
div.tab button {
background-color: inherit;
float: left;
border: none;
outline: none;
cursor: pointer;
padding: 14px 16px;
transition: 0.3s;
}
/* Change background color of buttons on hover */
div.tab button:hover {
background-color: #ddd;
}
/* Create an active/current tablink class */
div.tab button.active {
background-color: #ccc;
}
/* Style the tab content */
.tabcontent {
display: none;
padding: 6px 12px;
border: 0px solid #ccc;
border-top: none;
}
/* Style the buttons that are used to open and close the accordion panel */
button.accordion {
background-color: #eee;
color: #444;
cursor: pointer;
padding: 18px;
width: 100%;
text-align: left;
border: none;
outline: none;
transition: 0.4s;
}
/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
button.accordion.active, button.accordion:hover {
background-color: #ddd;
}
/* Style the accordion panel. Note: hidden by default */
div.panel {
padding: 0 18px;
background-color: white;
display: none;
}
</style>
