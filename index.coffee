Emitter = require "emitter"

module.exports = (element) ->
	emitter = new Emitter
	startX = 0
	startY = 0
	originX = 0
	originY = 0

	element.addEventListener "mousedown", initEvent = (e) ->
		originX = element.offsetLeft
		originY = element.offsetTop
		startX = event.pageX
		startY = event.pageY

		emitter.emit "dragstart", {element, originX, originY, startX, startY}

		document.addEventListener "mousemove", moveEvent = (e) ->
			element.style["left"] = (originX + (e.pageX - startX)) + "px"
			element.style["top"] = (originY + (e.pageY - startY)) + "px"

			emitter.emit "drag"

		document.addEventListener "mouseup", stopEvent = (e) ->
			stopX = e.pageX
			stopY = e.pageY

			emitter.emit "dragstop", {element, originX, originY, startX, startY, stopX, stopY}

			document.removeEventListener "mousemove", moveEvent
			document.removeEventListener "mouseup", stopEvent

	emitter.on "remove", -> element.removeEventListener "mousedown", initEvent

	emitter
