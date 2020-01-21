export const add = ({state}, tick) => {
	state.count += tick
};

export const subtract = ({state}, tick) => {
	state.count -= tick
};

export const getStuffById = async ({state, effects}, id) => {
	state.stuff.isLoading = true
	state.stuff.data = await effects.api.getStuffById({id})
	state.stuff.isLoading = false
}

export const getStuff = async ({ state, effects }) => {
	state.stuff.isLoading = true;
	state.stuff.data = await effects.api.getStuff();
	state.stuff.isLoading = false;
};