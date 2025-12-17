package com.musicplatform.util;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;

public class AWSStorageUtil {

    private static final String BUCKET_NAME = System.getenv("AWS_BUCKET_NAME");
    private static final String ACCESS_KEY = System.getenv("AWS_ACCESS_KEY");
    private static final String SECRET_KEY = System.getenv("AWS_SECRET_KEY");

    private static AmazonS3 s3Client;

    static {
        // Fallback or explicit region
        String region = System.getenv("AWS_REGION");
        if (region == null)
            region = Regions.US_EAST_1.getName();

        if (ACCESS_KEY != null && SECRET_KEY != null) {
            AWSCredentials credentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
            s3Client = AmazonS3ClientBuilder.standard()
                    .withCredentials(new AWSStaticCredentialsProvider(credentials))
                    .withRegion(region)
                    .build();
        } else {
            System.err.println("AWS Credentials not found in environment variables!");
            // Handle appropriately in production, maybe fallback or throw
        }
    }

    public static String uploadFile(String key, InputStream inputStream, long contentLength, String contentType) {
        if (s3Client == null)
            return null;

        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(contentLength);
            metadata.setContentType(contentType);

            PutObjectRequest request = new PutObjectRequest(BUCKET_NAME, key, inputStream, metadata);
            s3Client.putObject(request);

            return key; // Return the key as the reference
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getSignedUrl(String key) {
        if (s3Client == null)
            return null;

        // Generate pre-signed URL valid for 1 hour
        Date expiration = new Date();
        long expTimeMillis = expiration.getTime();
        expTimeMillis += 1000 * 60 * 60;
        expiration.setTime(expTimeMillis);

        try {
            URL url = s3Client.generatePresignedUrl(BUCKET_NAME, key, expiration);
            return url.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Helper to check if S3 is configured
    public static boolean isConfigured() {
        return s3Client != null && BUCKET_NAME != null;
    }
}
