import "phoenix_html"
import {Socket, Presence} from "phoenix"

let user = document.querySelector("#user").innerText
let socket = new Socket('/socket', {
	params: { user }
})
socket.connect()

let presences = {}

let formatedTimestamp = (ts) => {
	let date = new Date(ts)
	return date.toLocaleString()
}

let listBy = (user, { metas }) => {
	return {
		user,
		onlineAt: formatedTimestamp(metas[0].online_at)
	}
}

let userList = document.querySelector('#userList')
let render = (presences) => {
	userList.innerHTML = Presence.list(presences, listBy)
		.map(presence => `
			<li>
				${presence.user}
				<br />
				<small>online since ${presence.onlineAt}</small>
			</li>
		`).join('')
}
let room = socket.channel('room:lobby')
room.on('presence_state', state => {
	presences = Presence.syncState(presences, state)
	render(presences)
})

room.on('presence_diff', diff => {
	presences = Presence.syncDiff(presences, diff)
	render(presences)
})

room.join()



