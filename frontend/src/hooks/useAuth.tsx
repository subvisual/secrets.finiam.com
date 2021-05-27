import React, {
  createContext,
  ReactNode,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import Phoenix from 'phoenix';
import { useHistory, useLocation } from "react-router-dom";

export interface AuthContextType {
  loading: boolean;
  error?: string;

  connectSocket: () => void;
  connectRoom: (room: string) => void;
}

console.log(Phoenix)

const AuthContext = createContext<AuthContextType>({} as AuthContextType);

export function AuthProvider({
  children,
}: {
  children: ReactNode;
}): JSX.Element {
  const [error, setError] = useState<string | null>();
  const [loading, setLoading] = useState<boolean>(false);
  const history = useHistory();
  const location = useLocation();

  // @ts-ignore
  const socketAddress = import.meta.env.SNOWPACK_PUBLIC_SOCKET_ADDRESS

  useEffect(() => {
    if (error) setError(null);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [location.pathname]);

  function connectSocket() {
    setLoading(true);
    const { Socket } = Phoenix;

    const socket = new Socket(`${socketAddress}/socket`);
    socket.connect();

    socket.onOpen( _ev => {
      setLoading(false);
      setError(null);
    });
    socket.onError( error => {
      setLoading(false);
      setError(error);
      console.log('error')
      history.push("/");
    });
    socket.onClose( _ev => {
      setLoading(false);
      console.log('error')
      history.push("/");
    });
  }

  function connectRoom(room: string) {
    // function to connect elixir channel
  }

  // Make the provider update only when it should
  const memoedValue = useMemo(
    () => ({
      loading,
      error,
      connectSocket,
    }),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [loading, error]
  );

  return (
    <AuthContext.Provider value={memoedValue as AuthContextType}>
      {children}
    </AuthContext.Provider>
  );
}

export default function useAuth(): AuthContextType {
  return useContext(AuthContext);
}
