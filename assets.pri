RESOURCES += assets.qrc

# Use wget because curl get error code 33 for 100% downloading resume

!exists(shared/assets/texture/skybox) {
	message(downloading skybox)
	system(wget -cO skybox.rar http://learnopengl.com/img/textures/skybox.rar && unrar x skybox.rar shared/assets/texture/skybox/)
	exists(shared/assets/texture/skybox) {
		system(mv shared/assets/texture/skybox/left.jpg shared/assets/texture/skybox/skybox_negx.jpg)
		system(mv shared/assets/texture/skybox/bottom.jpg shared/assets/texture/skybox/skybox_negy.jpg)
		system(mv shared/assets/texture/skybox/front.jpg shared/assets/texture/skybox/skybox_negz.jpg)
		system(mv shared/assets/texture/skybox/right.jpg shared/assets/texture/skybox/skybox_posx.jpg)
		system(mv shared/assets/texture/skybox/top.jpg shared/assets/texture/skybox/skybox_posy.jpg)
		system(mv shared/assets/texture/skybox/back.jpg shared/assets/texture/skybox/skybox_posz.jpg)
		system(rm skybox.rar)
		message(downloaded skybox)
	} else {
		message(downloading failed)
	}
}

!exists(shared/assets/model/nanosuit.mtl) {
	message(downloading nanosuit)
	system(wget -cO nanosuit.rar http://learnopengl.com/data/models/nanosuit.rar && unrar x nanosuit.rar shared/assets/model/)
	exists(shared/assets/model/nanosuit.mtl) {
		system(rm nanosuit.rar)
		message(downloaded nanosuit)
	} else {
		message(downloading failed)
	}
}

!exists(shared/assets/model/planet.mtl) {
	message(downloading planet)
	system(wget -cO planet.rar http://learnopengl.com/data/models/planet.rar && unrar x planet.rar shared/assets/model/)
	exists(shared/assets/model/planet.mtl) {
		system(rm planet.rar)
		message(downloaded planet)
	} else {
		message(downloading failed)
	}
}

!exists(shared/assets/model/rock.mtl) {
	message(downloading rock)
	system(wget -cO rock.rar http://learnopengl.com/data/models/rock.rar && unrar x rock.rar shared/assets/model/)
	exists(shared/assets/model/rock.mtl) {
		system(rm rock.rar)
		message(downloaded rock)
	} else {
		message(downloading failed)
	}
}

message(assets checking passed)
