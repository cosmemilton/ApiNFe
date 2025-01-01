import axios from 'axios';

import UserImage from '../assets/img/wanna/wanna1.png';
import UserImageWebp from '../assets/img/wanna/wanna1.webp';
import { IUserProps } from '../common/data/userDummyData';

class AuthController {
  private serverUrl: string;

  constructor() {
    this.serverUrl = process.env.REACT_APP_SERVER_URL || '';
  }

  async login(usernameOrEmail: string, password: string): Promise<Partial<IUserProps>> {
    try {
      const url = `${this.serverUrl}/api/v1/admin/auth/login`;  
      console.log('url:', url);
      const response = await axios.post(url, {
        id:usernameOrEmail,
        password,
      });
      const userData = response.data.data;
      response.data.data.src = UserImage;
      response.data.data.srcSet = UserImageWebp;
      return userData;
    } catch (error:any) {
        if ( error.response && error.response.data && error.response.data.error) {
            throw error.response.data.error;  
        }
        throw error;
    }
  }
}

export default new AuthController();