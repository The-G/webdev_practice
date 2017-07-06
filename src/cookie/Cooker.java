package cookie;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class Cooker { // cookie 관리에 사용!
	private Map<String, Cookie> cookieMap = new HashMap<String, Cookie>(); // cookie 집어 넣을 hash map

	public Cooker(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies(); // 생성자에서 생성되는 순간 cookie 가져옴!!

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookieMap.put(cookies[i].getName(), cookies[i]); // cookie hash map 만듬!!
			}
		}
	}

	public boolean exist(String name) {
		return cookieMap.get(name) != null;
	}

	public Cookie getCookie(String name) {
		return cookieMap.get(name);
	}

	public String getValue(String name) throws UnsupportedEncodingException {
		Cookie cookie = cookieMap.get(name);

		if (cookie == null)
			return null;
		else
			return URLDecoder.decode(cookie.getValue(), "UTF-8");
	}

	public static Cookie createCookie(String name, String value) throws UnsupportedEncodingException {
		return new Cookie(name, URLEncoder.encode(value, "UTF-8"));
	}

	public static Cookie createCookie(String name, String value, int maxAge) throws UnsupportedEncodingException {

		Cookie cookie = new Cookie(name, URLEncoder.encode(value, "UTF-8"));
		cookie.setMaxAge(maxAge);
		return cookie;
	}
}