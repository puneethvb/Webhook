import social from '@salesforce/resourceUrl/social'
import punee from '@salesforce/resourceUrl/puneeth';
export const PROFILE_IMAGE = punee
export const SOCIAL_LINKS = [
    {
        type : 'twitter',
        label : 'twitter/punee83',
        url : 'https://twitter.com/punee83',
        icon : social+'SOCIAL/twitter.svg'
    },
    {
        type : 'facebook',
        label : 'facebook.com/puneeth.bharath',
        url : 'https://www.facebook.com/puneeth.bharath',
        icon : social+'SOCIAL/facebook.svg'
    },
    {
        type : 'trailhead',
        label : 'trailhead/pbharath',
        url : 'https://trailblazer.me/id/pbharath',
        icon : social+'SOCIAL/trailhead.svg'
    },
    {
        type : 'linkedin',
        label : 'linkedin.com/in/puneethbharath',
        url : 'https://www.linkedin.com/in/puneeth-bharath-2a328782',
        icon : social+'SOCIAL/linkedin.svg'
    }

]

export const USER_DETAILS = {
    name : 'Puneeth Bharath',
    role : 'Salesforce Architect',
    email : 'puneethvb@gmail.com',
    phone : '9632437373'
}