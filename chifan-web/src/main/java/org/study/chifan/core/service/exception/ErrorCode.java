/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/11/12.
 */
package org.study.chifan.core.service.exception;

public enum ErrorCode {
    //Common error codes
    COMMON_INVALID_PARAM(101001, "Invalid Parameter"),
    COMMON_INVALID_RESPONSE(101002,"Invalid Response"),
    COMMON_NO_SUPPORT_OPERATE(101003,"No Support Operate for Current Client"),
    COMMON_SERVER_INNER_ERROR(101005, "Server inner error"),


    //auth error codes
    INVALID_USER_STATUS(101101, "user whose status is not regular doesn't login"),
    USER_ACCOUNT_NOT_EXISTS(101102, "user account not exists"),
    AUTH_USER_FAILED(101103, "auth user failed because of incorrect account or password"),
    INVALID_TOKEN(101104, "invalid token or expired token"),
    AUTH_USER_EXCEPTION(101105, "auth user exception"),
    USER_DOESNOT_LOGIN(101106, "user doesn't login"),

    // user error codes
    USER_NOT_EXISTS(101201, "user not exists"),
    INVALID_USER(101202, "invalid user"),
    LIMITED_USER_PERMISSION(101203, "limited permission"),
    INVALID_USER_NAME(101204, "invalid user name"),
    INVALID_OLD_PASSWORD(101205, "invalid old password"),
    USER_ADD_EXCEPTION(101206, "user add exception"),
    USER_DELETE_EXCEPTION(101207, "user delete exception"),
    USER_EDIT_EXCEPTION(101208, "user edit exception"),
    USER_UPDATE_PASSWORD_EXCEPTION(101209, "user update password exception"),
    USER_RESET_PASSWORD_EXCEPTION(101210, "user reset password exception"),
    USER_UPDATE_STATUS_EXCEPTION(101219, "user update status exception"),
    USER_NEW_USER_NAME_EXIST(101211, " new user name %1$s  exist in %2$s domain_id"),
    USER_UPDATE_LOGIN_NAME_EXCEPTION(101212, "user update login name exception"),
    USER_BIND_QUOTA_EXCEPTION(101213, "user bind quota exception"),
    USER_UPDATE_QUOTA_EXCEPTION(101220, "user update quota exception"),
    USER_UNBIND_QUOTA_EXCEPTION(101214, "user unbind quota exception"),
    INVALID_PASSWORD(101216,"invalid password"),
    USER_TYPE_NOT_MATCH(101217,"user type is not matched"),
    USER_AUTH_EXCEPTION(101218,"user auth exception"),
    USER_QUERY_BYID_EXCEPTION(101219, "user query by id exception"),
    USER_QUERY_BYNAME_EXCEPTION(101220, "user query by name exception"),
    USER_DELETE_BYIDS_EXCEPTION(101221,"user delete by ids exception"),
    USER_CHANGE_PROFILE(101222,"user change profile exception"),
    USER_TRUNCATE_PROFILE(101223,"user truncate profile exception"),

	// file error codes
	INVALID_FILE_NAME(101301, "invalid file name"),
    INVALID_FILE_STATUS(101302, "invalid file status"),
    INVALID_FILE_PARENT(101303, "invalid parent folder"),
    INVALID_FILE_HASH(101304, "invalid file hash"),
    INVALID_FILE_ID(101305, "invalid file id"),
    DUPLICATED_ROOT_FOLDER_NAME(101306, "conflict root folder name"),
    DUPLICATED_FILE_NAME(101307, "conflict file name"),
    INCORRECT_OPERATION_ON_ROOT_FOLDER(101308, "incorrect operation on root folder"),
    INCORRECT_FILE_SORT_COLUMN(101309, "incorrect sort column of file"),
    FILE_NOT_EXISTED(101310, "file not existed"),
    FILE_IO_ERROR(101311, "file io exception"),
    INVALID_FILE_DATA(101322, "invalid file data"),
    CANNOT_MOVE_FILE(101312, "cannot move file into target folder"),
    UNLINKED_FILE(101313, "file is not linked"),
    INVALID_EXTERNAL_FILE_TOKEN(101314, "invalid external file token"),
    INVALID_FILE_TYPE(101323, "invalid file type"),
    EXCEED_MAX_LIMIT_USAGE(101315, "exceed the max limit of usage"),
    CANNOT_COPY_FILE(101316, "cannot copy file into target folder"),
    INVALID_MEDIA_CATEGORY(101317, "invalid media cateogry"),
    DUPLICATED_FOLDER_NAME(101318, "conflic folder name"),
    FILE_UPLOAD_NULL(101324, "upload file missing"),
    INVALID_FILE_SIZE(101319, "invalid file size"),
	THUMBNAIL_CONVERT_IMAGE_ERROR(101320,"thumbnail convert image error"),
	GET_THUMBNAIL_FROM_PATH_ERROR(101325,"get thumbnail convert exception"),
	THUMBNAIL_CONVERT_VIDEO_FRAME_ERROR(101321,"thumbnail convert video frame error"),
   INVALID_HASH_PARAM(101322,"Invalid hash parameter"),
    INVALID_FILE_NAME_PARAM(101323,"Invalid file name parameter"),

    //link/share error code
    INVALID_LINK(101401, "invalid link"),
    LINK_ADD_INVALID_FILEIDS(101402,"Public share error invalid fileids "),
    LINK_UPDATE_ERROR_EXIST_SHARE_FILEIDS(101414,"Public share update error:files for shared exists"),
    LINK_DELETE_EXCEPTION(101403,"Public share  delete exception"),
    LINK_GET_EXCEPTION(101404,"get Public share  exception"),
    LINK_INVALID_KEY(101405,"invalid link key"),
    LINK_FILELIST_IS_NULL(101407,"Public share file lists are null"),
    LINK_LIST_EXCEPTION(101406,"Public share file lists excpeption"),
    UNDISCOVERED_LINK(101415, "this link cannot be discovered"),
    INVALID_SHARE_ID(101409, "Invalid share id"),
    SHARE_MEMBER_NOT_EXISTS(101410, "Share member not exitst"),
    SHARE_NOT_EXISTS(101411, "Share not exitst"),
    INVALID_SHARE_PERMISSION(101412, "Invalid share permission"),
    EXIST_SHARE_FOR_FILE_ID(101413,"Exist share for file id"),
    SHARE_TO_SELF(101414,"Can't private share to self"),
    SHARE_MEMBER_DUPLICATED(101415,"Can't private share to member duplicated"),

	// quota,
	INVALID_QUOTA(101501, "quota doesnot exist"),
    QUOTA_ADD_EXCEPTION(101502, "quota add exception"),
    QUOTA_UPDATE_EXCEPTION(101503, "quota update exception"),
    QUOTA_DELETE_EXCEPTION(101504, "quota delete exception"),
    LIST_QUOTA_EXCEPTION(101505, "list quotas exception"),
    QUOTA_DELETE_HAVE_USER_EXCEPTION(101506,"quota delete fail:there are some users in the quota"),
    QUOTA_ADD_QUOTA_NAME_INVALID(101507,"quota add fail:quota name is invalidate"),

    // contact backup&restore
    CONTACT_BACKUPTIME_INVALID(102101, "contacts backup_time's format must be yyyyMMddHHmmss"),
    CONTACT_BACKUPFILE_INVALID(102102, "contacts backuped file's format is not valid"),
    CONTACT_CONTACTSJSON_INVALID(102103, "request body's contacts json is invalid"),
    CONTACT_BACKUPFILE_IOEXCEPTION(102104, "write contacts's json to file io exception"),
    CONTACT_BACKUPFILE_NOTEXIST(102105, "backuped file not exists"),
    CONTACT_CONTACTBACKUP_RECORDS_INVALID(102106, "contacts backup record is not valid"),
    CONTACT_FILEDB_NOTCONSISTENT(102107, "contacts backuped file and db is not consistent");


	private int statusCode;

	private String message;

	private ErrorCode(int statusCode, String message) {
		this.statusCode = statusCode;
		this.message = message;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public String getMessage() {
		return this.message;
	}

}
