import nativeToast from 'native-toast'
import { ToastOptions } from 'native-toast'

export function toast({
    message,
    type,
    timeout = 5000,
    position = 'north-east',
}: ToastOptions): void {
    nativeToast({
        message,
        type,
        timeout: timeout,
        position: position
    })
}