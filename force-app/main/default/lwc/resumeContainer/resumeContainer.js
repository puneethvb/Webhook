import { LightningElement } from 'lwc';
import * as RESUME_DATA from './resumeContainerData';

export default class ResumeContainer extends LightningElement {
    profileImage = RESUME_DATA.PROFILE_IMAGE;
    resumeData = RESUME_DATA;
    socialLinks = RESUME_DATA.SOCIAL_LINKS;
}