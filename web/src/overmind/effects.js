import axios from 'axios';

export const api = {
	getStuffById ({id,}) {
		return axios({
			url: `https://jsonplaceholder.typicode.com/todos/${id}`
		}).then(response => {
			const {
				data
			} = response;

			return data;
		}).catch(error => {
			log({axios: {error}});

			return;
		});

	},

	getStuff () {
		return axios({
			url: `https://jsonplaceholder.typicode.com/todos/`
		}).then(response => {
			const {
				data
			} = response;

			return data;
		}).catch(error => {
			log({axios: {error}});

			return;
		});

	}
}