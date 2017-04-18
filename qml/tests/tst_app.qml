import QtQuick 2.7
import QtTest 1.1

import "../Components"
import "utils.js" as Utils

Loader {
	id: appLoader
	width: 800
	height: 600
	source: "../main.qml"
	focus: true

	property bool interactive: false
	property var combo: null
	property var scene: null
	property var vkeys: null

	onStatusChanged: {
		if (status == Loader.Ready) {
			combo = Utils.getElementByCriteria(item, function(t){
				return t.hasOwnProperty("textRole") && t.textRole === "text";
			})[0];
		}
	}

	TestCase {
		name: "LearnOpenGL.QML.app"
		when: windowShown

		function initTestCase() {
			Resources.appPrefix = "file:../../";
			Resources.assetsPrefix = "file:../../";
		}

		function beforeTest(idx) {
			verify(combo);
			combo.currentIndex = idx;
			scene = null;
			scene = Utils.getElementByCriteria(appLoader.item, function(t){
				return t.hasOwnProperty("aspects");
			})[0];
			verify(scene);
			var vkeyss = null;
			vkeyss = Utils.getElementByCriteria(appLoader.item, function(t){
				return t["target"] === scene;
			});
			if (vkeyss.length) {
				vkeys = vkeyss[0];
				vkeys.active = true;
			}
		}

		function afterTest(idx, delay) {
			if (delay === undefined)
				delay = 1000;
			wait(delay);
			scene.grabToImage(function(result) {
				result.saveToFile("screenshots/"+idx+".png");
			})
		}

		function randomKeyClick(list, alpha, beta, total) {
			if (!interactive)
				return;

			if (alpha === undefined)
				alpha = 200;
			if (beta === undefined)
				beta = 50;
			if (total === undefined)
				total = 2000;

			var i;
			var elapse = 0;
			var tested = [], testedCount = 0;
			for (i in list)
				tested.push(false);
			scene.focus = true;
			while (elapse<total) {
				var t = Math.random() * alpha + beta;
				wait(t);
				elapse += t;
				i = parseInt(Math.random()*list.length);
				if (testedCount<list.length) {
					while (tested[i])
						i = parseInt(Math.random()*list.length);
					tested[i] = true;
					testedCount += 1;
				}
				keyClick(list[i]);
				//console.log(list[i], list, tested, testedCount);
			}
		}

		function randomFly(total) {
			if (!interactive)
				return;

			if (total === undefined)
				total = 2000;

			var i, dx = 0, dy = 0;
			var elapse = 0;
			scene.focus = true;
			while (elapse<total) {
				var t = 10;
				wait(t);
				elapse += t;
				keyPress(Qt.Key_Up);
				var rx = (Math.random()-.5) * 10;
				var ry = (Math.random()-.5) * 10;
				dx = (dx*7+rx)/8;
				dy = (dy*7+ry)/8;
				mouseDrag(scene, 400, 300, dx, dy);
			}
		}


		function test_hellowindow(){
			var idx = 0;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_hellotriangle(){
			var idx = 1;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_hellotriangle2(){
			var idx = 2;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_shaders_uniform(){
			var idx = 3;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_shaders_interpolated(){
			var idx = 4;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_textures2(){
			var idx = 5;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_textures_combined(){
			var idx = 6;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_transformations(){
			var idx = 7;
			beforeTest(idx);
			randomKeyClick([Qt.Key_Space], 300, 200);
			afterTest(idx, 0);
		}

		function test_coordinate_systems(){
			var idx = 8;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_coordinate_systems_with_depth(){
			var idx = 9;
			beforeTest(idx);
			randomKeyClick([Qt.Key_Space, Qt.Key_Return], 200, 150);
			afterTest(idx, 0);
		}

		function test_coordinate_systems_multiple_objects(){
			var idx = 10;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_camera_circle(){
			var idx = 11;
			beforeTest(idx);
			afterTest(idx);
		}

		function test_camera_keyboard_dt(){
			var idx = 12;
			beforeTest(idx);
			randomKeyClick([Qt.Key_Up, Qt.Key_Down, Qt.Key_Left, Qt.Key_Right,
						   Qt.Key_W, Qt.Key_S, Qt.Key_A, Qt.Key_D],
						   50, 20);
			afterTest(idx, 0);
		}

		function test_camera_zoom(){
			var idx = 13;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_colors_scene(){
			var idx = 14;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_basic_lighting_diffuse(){
			var idx = 15;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_basic_lighting_specular(){
			var idx = 16;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_materials(){
			var idx = 17;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_lighting_maps_specular(){
			var idx = 18;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_light_casters_directional(){
			var idx = 19;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_light_casters_spotlight_soft(){
			var idx = 20;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}

		function test_multiple_lights(){
			var idx = 21;
			beforeTest(idx);
			randomFly();
			afterTest(idx, 0);
		}
	}
}
