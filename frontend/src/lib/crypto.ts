/**
 * Props to https://bradyjoslin.com/blog/encryption-webcrypto/
 */

const enc = new TextEncoder();

const getPasswordKey = (password: string) =>
  window.crypto.subtle.importKey('raw', enc.encode(password), 'PBKDF2', false, ['deriveKey']);

const deriveKey = (passwordKey: CryptoKey, salt: ArrayBuffer, keyUsage: KeyUsage[]) =>
  window.crypto.subtle.deriveKey(
    {
      name: 'PBKDF2',
      salt,
      iterations: 250000,
      hash: 'SHA-256'
    },
    passwordKey,
    { name: 'AES-GCM', length: 256 },
    false,
    keyUsage
  );

const bufferToBase64 = (buff: ArrayBuffer) => btoa(String.fromCharCode.apply(null, buff));
const base64ToBuffer = (b64: string) => Uint8Array.from(atob(b64), (c) => c.charCodeAt(null));

export function generateRandomChars(number: number): string {
  return Array(number)
    .fill('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
    .map(
      (char) =>
        char[
          Math.floor(
            (crypto.getRandomValues(new Uint32Array(1))[0] / (0xffffffff + 1)) * char.length
          )
        ]
    )
    .join('');
}

export function generatePassphrase(): string {
  return generateRandomChars(32);
}

export async function encryptData(plainText: string, passphrase: string): Promise<string> {
  try {
    const salt = window.crypto.getRandomValues(new Uint8Array(16));
    const iv = window.crypto.getRandomValues(new Uint8Array(12));
    const passwordKey = await getPasswordKey(passphrase);
    const aesKey = await deriveKey(passwordKey, salt, ['encrypt']);
    const encryptedContent = await window.crypto.subtle.encrypt(
      {
        name: 'AES-GCM',
        iv: iv
      },
      aesKey,
      new TextEncoder().encode(plainText)
    );

    const encryptedContentArr = new Uint8Array(encryptedContent);
    const buff = new Uint8Array(salt.byteLength + iv.byteLength + encryptedContentArr.byteLength);
    buff.set(salt, 0);
    buff.set(iv, salt.byteLength);
    buff.set(encryptedContentArr, salt.byteLength + iv.byteLength);
    const base64Buff = bufferToBase64(buff);

    return base64Buff;
  } catch (e) {
    console.log(`Error - ${e}`);
    return '';
  }
}

export async function decryptData(encryptedText: string, passphrase: string): Promise<string> {
  try {
    const encryptedDataBuff = base64ToBuffer(encryptedText);
    const salt = encryptedDataBuff.slice(0, 16);
    const iv = encryptedDataBuff.slice(16, 16 + 12);
    const data = encryptedDataBuff.slice(16 + 12);
    const passwordKey = await getPasswordKey(passphrase);
    const aesKey = await deriveKey(passwordKey, salt, ['decrypt']);
    const decryptedContent = await window.crypto.subtle.decrypt(
      {
        name: 'AES-GCM',
        iv: iv
      },
      aesKey,
      data
    );

    return new TextDecoder().decode(decryptedContent);
  } catch (e) {
    console.log(`Error - ${e}`);
    return '';
  }
}
