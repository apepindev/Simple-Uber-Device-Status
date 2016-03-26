style =
	width: "50%"

	position:
		top:    "4.5em"
		bottom: "0"
		left:   "3%"
		right:  "0"

	font:            "SFNS Display, 'Helvetica Neue', sans-serif"
	font_color:      "white"
	font_size:       "32px"
	font_weight:     "bold"
	letter_spacing:  "0.025em"
	line_height:     ".9em"

	shadow:
		blur: 		"0px"
		x_offset: "1px"
		y_offset: "1px"
		color:    "rgba(0, 0, 0, .4)"

	text_align:     "left"

	icon_mouse:
		png: "devicebatt.widget/PNG/mouse-32.png"

	icon_keyboard:
		png: "devicebatt.widget/PNG/keyboard-2-32.png"

command: "system_profiler SPBluetoothDataType | grep -E 'Battery|Minor Type' | sed 's/Minor Type://g' | sed 's/Battery Level://g' | sed -e 's/^[ \t]*//' | paste -d' ' - -"

refreshFrequency: (1000 * 3)

renderInfo: (device, pctg) -> """
  <table id="devices">
		<tr class="device">
			<td class="icon-#{device} bg"></td>
			<td>#{pctg}</td>
		</tr>
	</table>
"""

# Update the rendered output.
update: (output, domEl) ->
	devices = output.split('\n')
	patt = /(.*?)(\d{1,3}%)/

	$(domEl).html ''
	render = @renderInfo

	for device, i in devices when device.match patt
    do (device) ->
      [match, name, pct] = device.match patt
      $(domEl).append render(name.toLowerCase(), pct)


style: """
	top: #{@style.position.top}
	bottom: #{@style.position.bottom}
	right: #{@style.position.right}
	left: #{@style.position.left}
	width: #{@style.width}
	font-family: #{@style.font}
	color: #{@style.font_color}
	font-weight: #{@style.font_weight}
	text-align: #{@style.text_align}
	text-transform: #{@style.text_transform}
	font-size: #{@style.font_size}
	letter-spacing: #{@style.letter_spacing}
	font-smoothing: antialiased
	text-shadow: #{@style.shadow.x_offset} #{@style.shadow.y_offset} #{@style.shadow.blur} #{@style.shadow.color}
	line-height: #{@style.line_height}

	.icon-mouse
		background: url('#{@style.icon_mouse.png}')
		-webkit-filter: drop-shadow(#{@style.shadow.x_offset} #{@style.shadow.y_offset} #{@style.shadow.blur} #{@style.shadow.color})
		filter: drop-shadow(#{@style.shadow.x_offset} #{@style.shadow.y_offset} #{@style.shadow.blur} #{@style.shadow.color})

	.icon-keyboard
		background: url('#{@style.icon_keyboard.png}')
		-webkit-filter: drop-shadow(#{@style.shadow.x_offset} #{@style.shadow.y_offset} #{@style.shadow.blur} #{@style.shadow.color})
		filter: drop-shadow(#{@style.shadow.x_offset} #{@style.shadow.y_offset} #{@style.shadow.blur} #{@style.shadow.color})

	.disabled
		zoom: 1
		opacity: 0.5

	.bg
    height: 40px
    width: 50px
    float: left
    background-position: center 5px
    background-repeat: no-repeat
    background-size: 32px 32px

"""
