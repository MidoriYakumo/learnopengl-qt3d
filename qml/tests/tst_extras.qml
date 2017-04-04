import QtQuick 2.7
import QtTest 1.1

import "../Components"
import "utils.js" as Utils


Loader {
	id: loader
	width: 800
	height: 600
	focus: true

	property bool interactive: false
	property var scene: null
	property var vkeys: null

	TestCase {
		name: "LearnOpenGL.QML.extras"
		when: windowShown

		function initTestCase() {
			Resources.appPrefix = "file:../../";
			Resources.assetsPrefix = "file:../../";
		}

		function beforeTest(name) {
			loader.source = "../" + name +".qml";
			scene = null;
			scene = Utils.getElementByCriteria(loader, function(t){
				return t.hasOwnProperty("aspects");
			})[0];
			verify(scene);
			var vkeyss = null;
			vkeyss = Utils.getElementByCriteria(loader, function(t){
				return t["target"] === scene;
			});
			if (vkeyss.length) {
				vkeys = vkeyss[0];
				vkeys.active = true;
			}
		}

		function afterTest(name, delay) {
			if (delay === undefined)
				delay = 1000;
			wait(delay);
			scene.grabToImage(function(result) {
				result.saveToFile("screenshots/"+name+".png");
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


		function test_hellowindow2(){
			beforeTest("hellowindow2");
			afterTest("hellowindow2");
		}

		function test_hello_triangle_exercise1(){
			beforeTest("hello-triangle-exercise1");
			afterTest("hello-triangle-exercise1");
		}

		function test_hello_triangle_exercise2(){
			beforeTest("hello-triangle-exercise2");
			afterTest("hello-triangle-exercise2");
		}

		function test_hello_triangle_exercise3(){
			beforeTest("hello-triangle-exercise3");
			afterTest("hello-triangle-exercise3");
		}

		function test_shaders_exercise1(){
			beforeTest("shaders-exercise1");
			afterTest("shaders-exercise1");
		}

		function test_shaders_exercise2(){
			beforeTest("shaders-exercise2");
			afterTest("shaders-exercise2");
		}

		function test_shaders_exercise3(){
			beforeTest("shaders-exercise3");
			afterTest("shaders-exercise3");
		}

		function test_textures(){
			beforeTest("textures");
			afterTest("textures");
		}

		function test_textures_exercise1(){
			beforeTest("textures-exercise1");
			afterTest("textures-exercise1");
		}

		function test_textures_exercise2(){
			beforeTest("textures-exercise2");
			afterTest("textures-exercise2");
		}

		function test_textures_exercise3(){
			beforeTest("textures-exercise3");
			afterTest("textures-exercise3");
		}

		function test_textures_exercise4(){
			beforeTest("textures-exercise4");
			randomKeyClick([Qt.Key_Up, Qt.Key_Down]);
			afterTest("textures-exercise4", 0);
		}

		function test_transformations_exercise1(){
			beforeTest("transformations-exercise1");
			randomKeyClick([Qt.Key_Space]);
			afterTest("transformations-exercise1", 0);
		}

		function test_transformations_exercise2(){
			beforeTest("transformations-exercise2");
			randomKeyClick([Qt.Key_Space]);
			afterTest("transformations-exercise2", 0);
		}

		function test_coordinate_systems_exercise1(){
			beforeTest("coordinate_systems-exercise1");
			randomKeyClick([Qt.Key_Up, Qt.Key_Down, Qt.Key_Left, Qt.Key_Right]);
			afterTest("coordinate_systems-exercise1", 0);
		}

		function test_coordinate_systems_exercise2(){
			beforeTest("coordinate_systems-exercise2");
			randomKeyClick([Qt.Key_Space]);
			afterTest("coordinate_systems-exercise2", 0);
		}

		function test_coordinate_systems_exercise3(){
			beforeTest("coordinate_systems-exercise3");
			randomKeyClick([Qt.Key_Space]);
			afterTest("coordinate_systems-exercise3", 0);
		}

		function test_camera_keyboard(){
			beforeTest("camera_keyboard");
			randomKeyClick([Qt.Key_Up, Qt.Key_Down, Qt.Key_Left, Qt.Key_Right,
						   Qt.Key_W, Qt.Key_S, Qt.Key_A, Qt.Key_D],
						   50, 20);
			afterTest("camera_keyboard", 0);
		}


		function test_camera_exercise1(){
			beforeTest("camera-exercise1");
			randomKeyClick([Qt.Key_Space], 100, 250, 1000);
			randomFly(1000);
			afterTest("camera-exercise1", 0);
		}

		function test_camera_exercise2(){
			beforeTest("camera-exercise2");
			randomFly();
			afterTest("camera-exercise2", 0);
		}

		function test_basic_lighting_exercise1(){
			beforeTest("basic_lighting-exercise1");
			randomFly();
			afterTest("basic_lighting-exercise1", 0);
		}

		function test_basic_lighting_exercise2(){
			beforeTest("basic_lighting-exercise2");
			randomFly();
			afterTest("basic_lighting-exercise2", 0);
		}

		function test_basic_lighting_exercise3(){
			beforeTest("basic_lighting-exercise3");
			randomFly();
			afterTest("basic_lighting-exercise3", 0);
		}

		function test_lighting_maps_diffuse(){
			beforeTest("lighting_maps_diffuse");
			randomFly();
			afterTest("lighting_maps_diffuse", 0);
		}

		function test_lighting_maps_exercise1(){
			beforeTest("lighting_maps-exercise1");
			randomFly();
			afterTest("lighting_maps-exercise1", 0);
		}

		function test_lighting_maps_exercise2(){
			beforeTest("lighting_maps-exercise2");
			randomFly();
			afterTest("lighting_maps-exercise2", 0);
		}

		function test_lighting_maps_exercise3(){
			beforeTest("lighting_maps-exercise3");
			randomFly();
			afterTest("lighting_maps-exercise3", 0);
		}

		function test_lighting_maps_exercise4(){
			beforeTest("lighting_maps-exercise4");
			randomFly();
			afterTest("lighting_maps-exercise4", 0);
		}
	}
}
