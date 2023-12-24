import ErrorHandler from '@/errorHandler';

type Options = {
  headers?: Record<string, string>;
  method?: "GET" | "POST" | "PUT" | "DELETE";
  body?: string;
}

async function fetchWrapper(
  url: string,
  options: Options = {}
) {
  options.headers = {
    ...options.headers,
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  }
  options.method = options.method || 'GET';
  const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
  const headers = {
    ...options.headers,
    'X-CSRF-Token': csrfToken
  };

  const fetchOptions = {
    ...options,
    headers
  };

  try {
    const response = await fetch(url, fetchOptions as RequestInit);

    const newCsrfToken = response.headers.get('X-CSRF-Token');
    if (newCsrfToken) {
      document.querySelector('meta[name="csrf-token"]')?.setAttribute('content', newCsrfToken);
    }

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.message || 'Server error');
    }

    return response;
  } catch (error) {
    ErrorHandler(error, 'fetchWrapper', 'fetchWrapper');
  }
}

export default fetchWrapper;
