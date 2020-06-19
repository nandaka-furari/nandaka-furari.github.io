window.addEventListener('load', (event) => {
	const header = new Vue({
		el:"#navi",
		data: {
			ha0: false,
			ha1: false,
			ha2: false
		},
		methods: {
			toggle: function(ha) {
				if(ha=='ha0') {
					this.ha0=!this.ha0;
				} else if(ha=='ha1') {
					this.ha1=!this.ha1;
				} else if(ha=='ha2') {
					this.ha2=!this.ha2;
				}
			}
		}
	})
  });