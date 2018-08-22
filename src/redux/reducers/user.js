var merge;

({merge} = require('./utils'));

module.exports = function(state = {}, action) {
    switch (action.type) {
        case 'USER_PROFILE':
            return merge(state, {
                profile: action.profile
            });
        default:
            return state;
    }
};
