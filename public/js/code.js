var arr = document.getElementsByClassName('sort-table');
var index;

for (index = 0; index < arr.length; ++index) {
  new Tablesort(arr[index]);
};