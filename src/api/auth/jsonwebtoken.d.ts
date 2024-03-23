declare module "jsonwebtoken" {
  export function sign(
    payload: any,
    secretOrPrivateKey: any,
    options?: any
  ): any;
  export function verify(
    payload: any,
    secretOrPrivateKey: any,
    options?: any
  ): any;
}
