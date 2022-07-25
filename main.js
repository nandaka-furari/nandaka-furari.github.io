window.addEventListener('load', (event) => {
	const header = new Vue({
		el:"#navi",
		data: {
			ha0: false,
			ha1: false,
			ha2: false,
			ha3: false
		},
		methods: {
			toggle: function(ha) {
				this[ha] = !this[ha];
			}
		}
	})
  });