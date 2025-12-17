package com.musicplatform.model;

import java.sql.Timestamp;

public class SystemSetting {
    private String key;
    private String value;
    private Timestamp updatedAt;

    public SystemSetting() {
    }

    public SystemSetting(String key, String value, Timestamp updatedAt) {
        this.key = key;
        this.value = value;
        this.updatedAt = updatedAt;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
