const fs = require('fs');
const rimraf = require('rimraf');
fs.unlink('.dest/test.html');
//rimraf('.dest',(e) => {console.log(e);});
fs.access('.dest',fs.constants.R_OK | fs.constants.W_OK,(err) => {
	console.log(err);
})