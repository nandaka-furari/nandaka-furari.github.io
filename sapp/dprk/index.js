let vm;
fetch("dprk.csv")
.then(response=>response.text())
.then(text=>{
	vm = app.mount("#app");
	vm.data = todata(text);
});

const 正確と思われる新規発熱者の最古日 = new Date(2022,4,17);
const 調べられる最古日 = new Date(2022,3,1);
const 北朝鮮の人口 = 2578_0000;

document.getElementById("正確と思われる新規発熱者の最古日").textContent=正確と思われる新規発熱者の最古日.toISOString();

function 人口10万人あたりの数(value){
	return value * 10_0000 / 北朝鮮の人口;
}

let chart;
function draw(data){
	let 平均七日間発熱者数Array = [];
	let 実行再生産数Array = [];
	let 日付Array = [];
	let 発熱者総計 = 0;
	for(let i=0; i<data.length; i++){
		//よく分からないエラーがあるのでif
		if(data[i].平均七日間発熱者数)発熱者総計 += Number(data[i].平均七日間発熱者数);
		console.log(発熱者総計);
		日付Array.push(data[i].日付);
		平均七日間発熱者数Array.push(data[i].平均七日間発熱者数);
		実行再生産数Array.push(data[i].実行再生産数);
	}
	var ctx = document.getElementById('mychart');

	console.log(ctx);
	if(chart) {
		chart.destroy();
	}
var myChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: 日付Array,
    datasets: [{
      label: '平均七日間発熱者数',
      data: 平均七日間発熱者数Array,
      borderColor: '#f88',
    }, {
      label: '実行再生産数',
      data: 実行再生産数Array,
      borderColor: '#484',
	  yAxisID: 'y2',
    }]
  },
  options: {
    scales: {
		y: {
		  min: 0,
		  max: 1_500_000,
		  ticks: {
			color: '#f88',
		  },
		},
		y2: {
		  min: 0,
		  max: 5,
		  position: 'right',
		  ticks: {
			color: '#48f',
		  },
		},
	  },
  },
});
chart = myChart;

return Math.trunc(発熱者総計);
}
function todata(text){
	let array = [];
	const records = text.split("\n");
	console.log(records.length);
	for(let i=0; i<records.length; i++) {
		const fields = records[i].split(",");
		array.push({日付:fields[0],新規発熱者数:fields[1],平均七日間発熱者数:fields[2],七日間合計:fields[3],実行再生産数:fields[4]});
	}
	console.log(array.length);
	return array;
}
function 実行再生産数を計算する(調べたい日,vm){
	const 調べたい日Time = new Date(調べたい日).getTime();
	const 感染始まりTime = new Date(vm.感染始まり日づけ).getTime();
	const 実行再生産数ピークTime = new Date(vm.実行再生産数ピーク日づけ).getTime();
	const 下げ止まりTime = new Date(vm.実行再生産数下げ止まりの日づけ).getTime();
	if( 調べたい日Time <= 感染始まりTime) {
		return 1;
	} else if(感染始まりTime <  調べたい日Time &&  調べたい日Time <= 実行再生産数ピークTime){
		//感染の始まりからピーク日まで1から直線状に実行再生産数は上がる
		return 1 + (vm.ピーク実行再生産数 - 1) * (調べたい日Time - 感染始まりTime) / (実行再生産数ピークTime - 感染始まりTime)
	} else if(実行再生産数ピークTime <  調べたい日Time &&  調べたい日Time <= 下げ止まりTime){
		//ピークから下げ止まりの時まで直線状に実行再生産数は下がる
		return vm.ピーク実行再生産数 - (vm.ピーク実行再生産数 - vm.基準実行再生産数) * (調べたい日Time - 実行再生産数ピークTime) / (下げ止まりTime - 実行再生産数ピークTime)
	} else if(下げ止まりTime < 調べたい日Time) {
		//下げ止まったら一定の数値
		return vm.基準実行再生産数;
	} else {
		console.error("何かミスした");
		return null;
	}
}
//ある日づけの位置
function indexOf(data,date){
	for(let i=0; i<data.length; i++){
		if(data[i].日付 == date){
			return i;
		}
	}
	return null;
}
function dateString(date){
	const iso = date.toISOString()
	return iso.slice(0,iso.indexOf('T'));
}
function addDays(date, days) {
	var result = new Date(date);
	result.setDate(result.getDate() + days);
	return result;
  }
const App = {
	data() {
		return {
			url:"",
			data:[],
			//何日か
			平均世代時間:2,
			//日本の場合の数字を初期値
			報告間隔:5,
			//推測値を初期値
			実行再生産数ピーク日づけ:"2022-05-05",
			//推測値を初期値
			感染始まり日づけ:"2022-04-20",
			//日本の場合
			ピーク実行再生産数:2.04,
			//実測できる数値から
			実行再生産数下げ止まりの日づけ:"2022-05-15",
			//初期値は何となく
			基準実行再生産数:0.75
		}
	},
	methods:{
		計算と描画:function(){
			console.log(dateString(正確と思われる新規発熱者の最古日));
			//七日後を対象にする
			const target = addDays(正確と思われる新規発熱者の最古日,7);
			console.log(dateString(target));
			const index = indexOf(this.data,dateString(target));
			console.log(index);
			for(let i=index - 1; i>=0; i--) {
				//さかのぼってデータを埋めていく
				const date = new Date(this.data[i].日付);
				console.log(date);
				//推測対象日なら計算を行う
				//求めるのは対象の平均七日発熱者数
				if(調べられる最古日.getTime() < date.getTime()) {
					//予測する日の13日後の実行再生産数を求める
					const 実行再生産数6日後 = 実行再生産数を計算する(this.data[i+6].日付,vm);
					//空白のはずなので値を入れる
					this.data[i+6].実行再生産数=実行再生産数6日後;
					//過去6日間の合計を求める
					const 七日間合計 = this.data[i+6].七日間合計 / Math.pow(実行再生産数6日後, this.指数);
					//データを入れる
					this.data[i].七日間合計 = 七日間合計;
					this.data[i].平均七日間発熱者数 = 七日間合計/7;
				} else {
					console.error("異常が発生したかも");
				}
			}

			//データの埋め合わせが終わったはずなので描画
			document.getElementById("発熱者総計").textContent = draw(this.data);
		}
	},
	computed:{
		指数:function(){
			return this.報告間隔 / this.平均世代時間
		},
		感染始まり日づけが正しいか:function(){
			return 調べられる最古日.getTime() < new Date(this.感染始まり日づけ).getTime();
		}

	}
}
const app = Vue.createApp(App);
