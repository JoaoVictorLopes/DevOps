package sgeol;

import org.springframework.data.mongodb.core.mapping.Field;
import java.time.LocalDateTime;

public class AccessLog {
	private String id;
	@Field(name="user-id")
	private String userId;
	private String message;
	@Field(name="http-verb")
	private String httpVerb;
	private String layer;
	private String resource;
	@Field(name="http-response-code")
	private int httpResponseCode;
	@Field(name="application-id")
	private String applicationId;
	@Field(name="authentication-time-process")
	private int authenticationTimeProcess;
	@Field(name="authorization-time-process")
	private int authorizationTimeProcess;
	@Field(name="request-time-process")
	private int requestTimeProcess;
	private LocalDateTime date;

	public String getId() {
		return id;
	}

	public String getUserId() {
		return userId;
	}

	public String getMessage() {
		return message;
	}

	public String getHttpVerb() {
		return httpVerb;
	}

	public String getLayer() {
		return layer;
	}

	public String getResource() {
		return resource;
	}

	public int getHttpResponseCode() {
		return httpResponseCode;
	}

	public String getApplicationId() {
		return applicationId;
	}

	public int getAuthenticationTimeProcess() {
		return authenticationTimeProcess;
	}

	public int getAuthorizationTimeProcess() {
		return authorizationTimeProcess;
	}

	public int getRequestTimeProcess() {
		return requestTimeProcess;
	}

	public LocalDateTime getDate() {
		return date;
	}

	@Override
	public String toString() {
		return "AccessLog [id=" + id + ", layer=" + layer + ", date=" + date + "]";
	}
}
