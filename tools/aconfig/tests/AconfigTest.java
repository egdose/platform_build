import static com.android.aconfig.test.Flags.FLAG_DISABLED_RO;
import static com.android.aconfig.test.Flags.FLAG_DISABLED_RW;
import static com.android.aconfig.test.Flags.FLAG_ENABLED_RO;
import static com.android.aconfig.test.Flags.FLAG_ENABLED_RW;
import static com.android.aconfig.test.Flags.disabledRo;
import static com.android.aconfig.test.Flags.disabledRw;
import static com.android.aconfig.test.Flags.enabledRo;
import static com.android.aconfig.test.Flags.enabledRw;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public final class AconfigTest {
    @Test
    public void testDisabledReadOnlyFlag() {
        assertEquals("com.android.aconfig.test.disabled_ro", FLAG_DISABLED_RO);
        assertFalse(disabledRo());
    }

    @Test
    public void testEnabledReadOnlyFlag() {
        assertEquals("com.android.aconfig.test.disabled_rw", FLAG_DISABLED_RW);
        // TODO: change to assertTrue(enabledRo()) when the build supports reading tests/*.values
        // (currently all flags are assigned the default READ_ONLY + DISABLED)
        assertFalse(enabledRo());
    }

    @Test
    public void testDisabledReadWriteFlag() {
        assertEquals("com.android.aconfig.test.enabled_ro", FLAG_ENABLED_RO);
        assertFalse(disabledRw());
    }

    @Test
    public void testEnabledReadWriteFlag() {
        assertEquals("com.android.aconfig.test.enabled_rw", FLAG_ENABLED_RW);
        // TODO: change to assertTrue(enabledRw()) when the build supports reading tests/*.values
        // (currently all flags are assigned the default READ_ONLY + DISABLED)
        assertFalse(enabledRw());
    }
}
