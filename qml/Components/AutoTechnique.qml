import QtQuick 2.9

import Qt3D.Render 2.0

Technique {
	/*
	  Unified routing for Qt5.9
	*/

	graphicsApiFilter {
		profile: GraphicsInfo.profile === GraphicsInfo.CoreProfile ?
			GraphicsApiFilter.CoreProfile : GraphicsApiFilter.NoProfile;
	}
}
