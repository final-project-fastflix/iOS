//
//  DataOfDeby.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

class ImagesData {
  static let shared = ImagesData()
  
  var imagesUrl = [
    // 블랙팬서
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABQUaT3DnhG1E9mUB07Y0eFVaI3uElN0GDe5ZLYWYQmqk2cCMkLLLdhhRXb8U9_I10ZT4jv9Xdd82jrVdnmHd3oC6820Fh6eRlw_LC_HEzvWH8tvc6-aWN87Hh68.jpg?r=56a",
    
    "https://i.ytimg.com/vi/lgPi5GhEj0c/maxresdefault.jpg",
    // 아이언맨3
    "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2FVtrUH%2FbtqwWf6Z4m5%2Fu0rGXHCt1RQ7fVcRyu04YK%2Fimg.jpg",
    
    
    
    // 로고
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/5e0byrbbfBPBmtxyXMpKqMuqOQY/AAAABfXvo4UeygOJQcz2yvD0NUGqo8_HY3ajqeoK64NFkByNzI7ZVAiCllvFug5MYMGsI7yG1d8Jo880z709_Kewn3ySq2tQwwdNG3b1bMXvWA.png?r=a7c",
    // 아이언맨3
    
    "https://mblogthumb-phinf.pstatic.net/20150324_48/goodman19_14271638762850JKMg_PNG/ironman-3-logo-png-29zk15id.png?type=w2",
   
    //
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABSoz_-IrQIFV0HDg-JNupS8Yn31G1kmQz7Y9s-ePYdxYyzDdsVz0ocmcvLz4eAtpBa9yOaWWjFbAURyns7AeIfCXRCuA-gt8sw.jpg?r=48d",
    
    //  로고
    "https://user-images.githubusercontent.com/48317281/61708349-92682600-ad87-11e9-8858-4445f9b490c2.png"
    
  ]
  
  var originalImages = [
    // 기묘한 이야기
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABTKFHlDa6dEOZZv5YTHVNBHUuyZ6GPz4rBrO2sSkqdszhpSe97qPRvTu_K0lRNiEH7yFYqV1I86UzA13wMxq9ccORyWxpzpsDWoX3jbAQ9wt-MWCqIlKgt6gklzdqq40oemDQj3IEoYHr5sm8RQZU0Cnt-8zaaYpuNM4tjScHSjsD0mgRbT4fuG8f_yZp4Ul_OXS5IltSGyi5Q7uR44TJ13ml7R4n5uK20t9Q4rAmA.jpg?r=03b",
    
    // 지정생존자 - 2
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABfMmtrbIm4g_0mBLwgINjA5-7qZjSECucRoKOXUDgcQedfgWBLeoUAuW3hMdKeYnolMCOTmMsAu5fOotKEf9jGp5R1bbYbC6ypDJwmtSSGFs3aMolFl_2a3ODhfDmNwYWvCxY14uZJJl675DMvA5atEogQIF-_vhNk6UQ-aM4TFQLq5scJhmLb5cN7FPb0LRLq8fIvXr.jpg?r=e9c",
    // 킹덤 - 3
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABSnabhlh7RAbz1j5sPs5VSkD5BsWh5jb3XPknkXCBYDLMrKYg98DNdcyLcoYB4BBkY_bPOlRPilkIdWTRjohLAEFvt34riCitasv9DQ8FKEx1YlGXDDM1SafIWlOkhOCScNO0kSt4IaXoiHrhw5EFbckkPXyChPDIR7sLG5XWDkgT_5kI6cHNbAB_gmU-uD3ceaLstWA.jpg?r=881",
    
    // 어쩌다 로맨스
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABaPSINFuzTTmbA-ss8QGHNsmg82wqeNQ3XOLRtgYDfrwAZGxFsgkWEVraMWqxpmIgsWOuF5VyQ8YSU0HswJpYjoyWApO60z_qL71okNG3O13wkA0hMRXyc3MCqlJ6H9w-DzBZJtRALS0bFVMgdylAiliajqCMdJ5joFxBUxj1B0GbvV-6-lRmdUU0_X2F82_Hw3EdWrj.jpg?r=fcd",
    // 내가 사랑했던 모든 남자들에게
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABaZzqaABXRAmSj_D6Bw_eiGJ5cXQT1dQiD30IYAajpG_8LNjKCkA59vEwlrHDqTgET7WeCpIPbFnJaN-OYZjrY6DUzgxDEXC3A8gEw3JMwT3-EcuVg0UzwhqNnmHUI9hKFIgX3_TmfILgP3b4fjEDFNXw6cq38lbv8Q3riVKR0kA7UrxYq7XYyggspVgfC2BsTxYk5lE.jpg?r=873",
    
    // 버드박스
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABdXvWszdSB9Te04QowtRqUgV5I84njLd1-u-A5HH8AZCGKl6CkVOBErBPOBmwIW_201e94g3AjzxihTCcMpmZ1nl7L1ksUZYVMsLMjouY7gnDIJEDKXSeXZSaO0MWs4scgIKuwrqeGm7f0cvb1rm2UobHamoK6ECckjy9Rm9uqZG__kGGuCz-DAo-mPk_ZS1Wx62xnE7.jpg?r=7ef",
    // 오렌지
    "https://occ-0-3446-1007.1.nflxso.net/dnm/api/v6/CFXrEYtXxhcqF3ItF4DehdUbQjk/AAAABXLhEohYBrhJ56ArSqwMPzV6KJex-lgQaJ0hnkACdVgIKZ59UU-IQI0oAwr7sKmk70s0NtcoSmOS8w_dJjFi53DQy6W7lDcdXluzqHFs5-Vbv2yI7p4Ua5K9ykIerun2DcQp9qSNLgNTBrYhXwUzURV8A2kmdMT_kXPPvNSVu_K-_lwsXJLPPY4dS-PI7ewKEb4bLNoE.jpg?r=a11"
  ]
  
  //  init(imagesUrl: [String]) {
  //    self.imagesUrl = imagesUrl
  //  }
}


//class ImagesData {
//
//  var imagesUrl: [String]
//
//  init(imagesUrl: [String]) {
//    self.imagesUrl = imagesUrl
//  }
//}
