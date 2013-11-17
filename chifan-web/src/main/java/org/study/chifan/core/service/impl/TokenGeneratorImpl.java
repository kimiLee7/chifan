package org.study.chifan.core.service.impl;

import java.util.Random;

import org.springframework.stereotype.Component;

import org.study.chifan.core.service.TokenGenerator;
import com.google.common.base.Strings;

@Component
public class TokenGeneratorImpl implements TokenGenerator {

    private static final int RANDOM_NUMBER_BOUND = 1000000;

    private Random random = new Random();

    public String generate() {
        int i = random.nextInt(RANDOM_NUMBER_BOUND);
        return Strings.padStart(String.valueOf(i), 6, '0');
    }
}
