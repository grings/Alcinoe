package io.magicfoundation.alcinoe.broadcastreceiver;

import android.content.Context;
import android.content.Intent;

public interface ALBroadcastReceiverListener {
  public void onReceive(Context context, Intent intent);
}
